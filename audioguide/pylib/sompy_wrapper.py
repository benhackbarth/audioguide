from __future__ import print_function

import numpy as np
import sompy as SOM
from sklearn.cluster import AffinityPropagation,DBSCAN,KMeans,AgglomerativeClustering


def dataScaling(featuresCorpus, featuresTargets, scaling_type):
	from sklearn import preprocessing
	#print featuresCorpus, featuresTargets, scaling_type
	if scaling_type == 'independent':
		scaler = preprocessing.StandardScaler().fit(featuresCorpus)
		featuresCorpus = scaler.transform(featuresCorpus)
		scaler2 = preprocessing.StandardScaler().fit(featuresTargets)
		featuresTargets = scaler2.transform(featuresTargets)
	else:
		scaler = preprocessing.StandardScaler().fit(featuresCorpus)
		featuresCorpus = scaler.transform(featuresCorpus)
		featuresTargets = scaler.transform(featuresTargets)
	return featuresCorpus, featuresTargets


def dataScaling2(features):
	from sklearn import preprocessing
	scaler = preprocessing.StandardScaler().fit(features)
	featuresNormed = scaler.transform(features)
	return featuresNormed


def setup(path2feat_corpus,path2feat_target,feat2use,path2audiofiles,path2feat_names,scaling_type):
    
    # Import features
    #----------------
    import glob
    featuresCorpus = np.loadtxt(path2feat_corpus,dtype=np.float,delimiter=',')
    featuresCorpus = featuresCorpus[:,feat2use]
    featuresTargets = np.loadtxt(path2feat_target,dtype=np.float,delimiter=',')
    featuresTargets = featuresTargets[:,feat2use]
    instancesCorpus = glob.glob(path2audiofiles + "/corpus*.wav")
    instancesTargets = glob.glob(path2audiofiles + "/target*.wav")
    features_names = np.loadtxt(path2feat_names,dtype=np.str,delimiter=',')        

    # Standarise sets
    #----------------
    featuresCorpus, featuresTargets = dataScaling(featuresCorpus, featuresTargets, scaling_type)
    print('Corpus: #features='+str(featuresCorpus.shape[1])+' . #soundfiles = ' + str(featuresCorpus.shape[0]) )
    print('Target: #features='+str(featuresTargets.shape[1])+' . #soundfiles = ' + str(featuresTargets.shape[0]) ) 
    return featuresCorpus, featuresTargets, instancesTargets, instancesCorpus


def classifySamples(testDataIn, numbClasses, hitMapBool):
	  sm = SOM.SOM('sm', trainDataIn, mapsize = [numbClasses, numbClasses], norm_method = 'var', initmethod='pca')
	  sm.train(n_job=1, shared_memory='no',verbose='off')

	  if hitMapBool: sm.hit_map(testDataIn)

	  testData_proj = sm.project_data(testDataIn)
	  testData_loc = sm.ind_to_xy(testData_proj)[:,2]

	  return testData_loc





def clusterSamples(model,trainDataIn,testDataIn,params):
    
    if model == 'SOM':
        
        # Map size 
        msz0 = params[0]
        msz1 = params[1]

        #print('SOM size: ', trainDataIn.shape[0])
        sm = SOM.SOM('sm', trainDataIn, mapsize = [msz0, msz1],norm_method = 'var',initmethod='pca')
        sm.train(n_job = 1, shared_memory = 'no',verbose='off')
        #sm.set_data_labels(list(instancesCorpus))

        if params[2] == True:
            #print('Hitmap for CORPUS (train, red) and TARGET (test, blue) data:')        
            sm.hit_map(testDataIn)

        testData_proj = sm.project_data(testDataIn)
        trainData_proj = sm.project_data(trainDataIn)
        testData_loc = sm.ind_to_xy(testData_proj)[:,2]
        trainData_loc = sm.ind_to_xy(trainData_proj)[:,2]

        return trainData_loc, testData_loc, sm

    if model == 'AffinityPropagation':
        
        model = AffinityPropagation()
        model.fit(trainDataIn)
        
        return model.predict(trainDataIn), model.predict(testDataIn), model
    
    if model == 'DBSCAN':
        
        model = DBSCAN()
        model.fit(trainDataIn)
        
        return model.fit_predict(trainDataIn), model.fit_predict(testDataIn), model

    if model == 'KMeans':
        
        model = KMeans(n_clusters=params[0])
        model.fit(trainDataIn)
        
        return model.predict(trainDataIn), model.predict(testDataIn), model
    
    if model == 'AgglomerativeClustering':
        model = AgglomerativeClustering(n_clusters=params[0])
        model.fit(trainDataIn)
        
        return model.fit_predict(trainDataIn), model.fit_predict(testDataIn), model    
    
def generateSequence(corpusClusters, targetClusters, suffix, path2export):

    import random

    seq_out = []
    verbose = False
    file_idx = -1

    for target in range(len(targetClusters)):
        file_idx += 1
        train_matches = (corpusClusters == corpusClusters[target])
        train_matches_i = train_matches.nonzero()
        seq_out.append(random.choice(train_matches_i))        
    #print('\n\nFinal sequence (index of coprus files to play):')
    #pprint.pprint(seq_out)    
    
    #np.savetxt(, (seq_out), delimiter=',')
    
    with open(str(path2export+'/seq_out_'+suffix+'.txt'),"w") as f:
        f.write("\n".join(",".join(map(str, x)) for x in seq_out))
    
    return seq_out

def generateTracks(seq_out,instancesTargets,instancesCorpus,starttimes,fs,suffix,path2export,saveTarget=False):

    import scikits.audiolab as audio6
    
    sound_out_save_target = []
    sound_out_save_corpus = []
    sound_out_save_mix = []

    file_idx = -1
    
    for corpus_file in seq_out:

        file_idx += 1

        # Add silience before start time of next target
        startsample = np.int(np.ceil(starttimes[file_idx] * fs))
        dt_target = len(sound_out_save_target) - startsample
        dt_corpus = len(sound_out_save_corpus) - startsample
        #print('startsample: ' + str(startsample) + '; dt_target: ' + str(dt_target) + '; dt_corpus: ' + str(dt_corpus), end="\r")
        if dt_target < 0:
            sound_out_save_target = np.concatenate([sound_out_save_target,np.zeros(abs(dt_target)+1)])
        if dt_corpus < 0:
            sound_out_save_corpus = np.concatenate([sound_out_save_corpus,np.zeros(abs(dt_corpus)+1)])

        # Load target segment to play next
        audioInT = audio6.wavread(instancesTargets[file_idx])[0]    
        if audioInT.ndim>1:
            audioInT = audioInT[:,0] + audioInT[:,1] 

        # Load corpus segment to play next
        if len(corpus_file) <> 0:
            #corpus2load = instancesCorpus[random.choice(corpus_file)] 
            audioInC = audio6.wavread(instancesCorpus[corpus_file[0]])[0]
            if audioInC.ndim>1:
                audioInC = audioInC[:,0] + audioInC[:,1]
            if len(audioInC) > len(audioInT):    
                audioInC = audioInC[0:len(audioInT)-1]
        else:
            audioInC = np.zeros(len(audioInT))            

        # Concatenate corpus and target segments
        sound_out_save_target = np.concatenate((sound_out_save_target,audioInT))
        sound_out_save_corpus = np.concatenate((sound_out_save_corpus,audioInC))
        
        if file_idx == len(seq_out)-1:
            sound_out_save_corpus = np.concatenate((sound_out_save_corpus,np.zeros(len(sound_out_save_target)-len(sound_out_save_corpus))))
            
        print('target: ' + str(len(sound_out_save_target)) + '; corpus: ' + str(len(sound_out_save_corpus)), end='\r')

    #print('Target length: ' + str(len(sound_out_save_target)) + 'samples; Corpus length: ' + str(len(sound_out_save_corpus)) + ' samples') 
    # Output to audio files
    if saveTarget == True:
        target_out = sound_out_save_target
        #target_out /= np.max(np.abs(target_out),axis=0)
        audio6.wavwrite(target_out,path2export+'/track_target.wav',fs=44100)
        print('> Audio files exported: '+ path2export +'/track_target.wav')
    corpus_out = sound_out_save_corpus
    #corpus_out /= np.max(np.abs(corpus_out),axis=0)
    audio6.wavwrite(corpus_out,path2export+'/track_corpus_'+suffix+'.wav',fs=44100)
    print('> Audio files exported: '+ path2export +'/track_corpus_'+suffix+'.wav')
    
    mix_out = sound_out_save_target+sound_out_save_corpus
    mix_out /= np.max(np.abs(mix_out),axis=0)
    audio6.wavwrite(mix_out,path2export+'/track_mix_'+suffix+'.wav',fs=44100)
    print('> Audio files exported: '+ path2export +'/track_mix_'+suffix+'.wav')
    
    return True