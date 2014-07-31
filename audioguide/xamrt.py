'''
Xamrt - cross-associative tree regression algorithm
(c) 2009, 2010 Dan Stowell
All rights reserved.

    Xamrt is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Xamrt is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with kdpee.  If not, see <http://www.gnu.org/licenses/>.


'''
from numpy import *
from numpy.random import randn, rand
from numpy.linalg import eigh as eigh
from numpy.random import randn

# fairly standard PCA algo; thanks to http://www.procoders.net/?p=124
def pca(data):
    values, vecs = eigh(cov(data))
    perm = argsort(-values)  # sort in descending order
    return values[perm], vecs[:, perm]

# finds the first principal component of the balanced concatenation of two datasets
def pcdual(data1, data2, dims=0, e=0.000000000001):
	if dims == 0:
		dims = data1.shape[1]
	else:
		# Supplied a dims argument so maybe we need to truncate the matrices
		data1 = data1[:,:dims]
		data2 = data2[:,:dims]
	tmag = 0
	from random import choice
	p = choice([choice(data1), choice(data2)])
	if not(any(p != 0)): # If zero we get stuck, so add noise
		p = randn(*shape(p)) * 0.1
	size1 = float(data1.shape[0])
	size2 = float(data2.shape[0])
	w1 = size2/(size1+size2)
	w2 = size1/(size1+size2)
	inc = float("inf")
	while inc > e :
		t = (dot(dot(data1, p), data1) * w1) + (dot(dot(data2, p), data2) * w2)
		tmag_old = tmag
		tmag = sqrt(sum(t*t))
		p = t / tmag
		inc = tmag - tmag_old
	return p

class Xamrt(object):
	
	gnuplotpath = '/opt/local/bin/gnuplot'
	
	# Processes CSV files, writing new CSV files in PlaneTree format, and 
	# also returning the Xamrt instance in case you want it.
	# "normalise" can be set to true to normalise the stddevs of the axes before calculation (then rescaled afterwards back to the original domain).
	# "matchercols" only useful for rare validation purposes: if the datasets can be sorted by these cols to yield the natural matching orders, it will validate based on that.
	@classmethod
	def processcsv(cls, path0, path1, dims=0, sizethresh=1, maxdepth=99, plot=True, startrow0=0, startrow1=0, prune=0, \
		# Note that colindices are applied AFTER the startcol stuff so the startcol can add an offset:
		startcol0=0, startcol1=0, colindices0=-1, colindices1=-1, outdir='', normalise=False, \
			matchercols=-1,   #if there's a column which you expect to match up exactly between the datasets (for validation)
			revmapcols0=-1, revmapcols1=-1    # if specified then writes out .trevmap data - often will use "controls" columns
			):
		import csv, os
		
		if not os.path.exists(path0):
			raise ValueError, 'file not found: %s' % (path0)
		if not os.path.exists(path1):
			raise ValueError, 'file not found: %s' % (path1)
		
		# Load the two CSV files
		data0 = []
		sorters0 = []
		revmap0 = []
		reader = csv.reader(open(path0))
		for blah in range(startrow0):
			arow = reader.next() # skip rows as needed
		while True:
			try:
				arow = reader.next()
				arow = map(float, arow[startcol0:])
				if not(matchercols == -1):
					sorters0.append(map(lambda x: arow[x], matchercols))
				if not(revmapcols0 == -1):
					revmap0.append(map(lambda x: arow[x], revmapcols0))
				if not(colindices0 == -1):
					arow = map(lambda x: arow[x], colindices0)
				data0.append(arow)
			except StopIteration: break
		
		data1 = []
		sorters1 = []
		revmap1 = []
		reader = csv.reader(open(path1))
		for blah in range(startrow1):
			arow = reader.next() # skip rows as needed
		while True:
			try:
				arow = reader.next()
				arow = map(float, arow[startcol1:])
				if not(matchercols == -1):
					sorters1.append(map(lambda x: arow[x], matchercols))
				if not(revmapcols1 == -1):
					revmap1.append(map(lambda x: arow[x], revmapcols1))
				if not(colindices1 == -1):
					arow = map(lambda x: arow[x], colindices1)
				data1.append(arow)

			except StopIteration: break
		
		data0 = array(data0)
		data1 = array(data1)
		if dims == 0:
			dims = data0.shape[1]
			print "Automatically set dimensionality as %d" % (dims)
		
		################## THE MAIN CALCULATION #################
		if normalise:
			scalefac = (data0.std(0) + data1.std(0)) * 0.5
			print "Normalising by these stdevs:"
			print scalefac
			n_data0 = data0 / scalefac
			n_data1 = data1 / scalefac
			p = cls(n_data0, n_data1, dims, sizethresh, maxdepth)
		else:
			p = cls(  data0,   data1, dims, sizethresh, maxdepth)
		
		print "Mean depth: %g" % (p.meandepth())
		print "Num leaves: %g" % (p.numleaves())
		if prune != 0:
			print "Pruning..."
			p.prune(prune)
			print "done."
			print "Mean depth: %g" % (p.meandepth())
			print "Num leaves: %g" % (p.numleaves())

		if normalise:		
			p.scale(scalefac)

		print "Validating..."
		if not(p.validate(data0, data1, inexact=normalise)):
			print "Validation unsuccessful"
			return False
		print "done."
		
		# if this is a map-to-self run with a high branching then we would expect most entries to have a unique mapping - so check:
		if (path0 == path1) and (maxdepth > 50) and (sizethresh == 1):
			print "Map-to-self, so checking for nonunique entries..."
			for index, clust in enumerate(p.clusters()):
				for which in [0,1]:
					if len(clust[which]) > 1:
						print "nonunique in cluster[%i][%i]:" % (index, which)
						for row in clust[which]:
							print row
							print p.classify(row, which)#, True)
			print "done."
		
		if matchercols != -1:
			print "Running matchercols validation on these columns:"
			print matchercols
			
			# add indices onto the END so we can retrieve indices afterwards.
			# this zipping results in shapes like [([3, 4], 0), ([5, 6], 1), ([1, 2], 2), ([7, 7], 3)]
			sort0 = zip(sorters0, range(len(sorters0)))
			sort1 = zip(sorters1, range(len(sorters1)))
			
			def comparematchercols(a,b):
				for whichcol in range(len(matchercols)):
					if a[0][whichcol] != b[0][whichcol]:
						return cmp(a[0][whichcol], b[0][whichcol])
				return 0
			
			sort0.sort(comparematchercols)
			sort1.sort(comparematchercols)
			
			# These are the sorting orders we'll use:
			order0 = map(lambda row: row[-1], sort0)
			order1 = map(lambda row: row[-1], sort1)
			
			# Check OKness - we expect the two lists of matchercols to contain the same data, so:
			if any( (array(sorters0)[order0])  != (array(sorters1)[order1]) ):
				print "ERROR in matchercols validation: sorter columns don't sort to same order"
				print array(sorters0)[order0]
				print array(sorters1)[order1]
			
			# NOW we can sort the actual data
			data0_s = data0[order0]
			data1_s = data1[order1]
			
			dists = []
			for i in range(len(data0)):
				c0 = p.classify(data0_s[i][:dims], 0)
				c1 = p.classify(data1_s[i][:dims], 1)
				dists.append(cls.treedistance(c0, c1))
			from scipy.stats import scoreatpercentile
			print "percentiles of tree-distances:"
			print map(lambda p: scoreatpercentile(dists, p), [0, 25, 50, 75, 100])
				
		
		# ensure outdir exists
		if outdir=='':
			outdir = os.path.dirname(path1)
		if not(os.path.exists(outdir)):
			os.mkdir(outdir)
		
		# Write the CSV files in PlaneTree format - include the settings in the filename
		outpath = '%s/%s_%s_d%dm%dp%d' % (outdir, \
					os.path.basename(os.path.splitext(path0)[0]), \
					os.path.basename(os.path.splitext(path1)[0]), \
					dims, maxdepth, int(prune * 100))
		print "writing to %s" % (outpath) 
		p.write(outpath, data0, data1, revmap0, revmap1)
		
		if plot:
			p.scatter(9, p.dims > 3)
			p.vecmap(9, p.dims > 3)
		
		return p
		
		
	#################
	# Constructor
	# (Note: do NOT supply the pathInt argument, it's used for recursion)
	def __init__(self, data0, data1, dims, sizethresh=2, maxdepth=Inf, pathInt=1):
		# Ensure numpy
		data0 = array(data0)
		data1 = array(data1)
		self.dims = dims
		# We don't change the data scaling but we do centre it.
		self.centre0 = mean(data0[:,:dims], 0)
		self.centre1 = mean(data1[:,:dims], 0)
		cdata0 = data0[:,:dims] - self.centre0
		cdata1 = data1[:,:dims] - self.centre1
		# Then we find the PC (the normal vector)
		self.pc = pcdual(cdata0, cdata1, dims)
		
		# Then we partition the data according to whether it's above or below the plane perp to the PC
		d0l = []
		d0r = []
		for index,datum in enumerate(cdata0):
			if sum(datum[:dims] * self.pc) > 0.0:
				d0l.append(data0[index])
			else:
				d0r.append(data0[index])
		d1l = []
		d1r = []
		for index, datum in enumerate(cdata1):
			if sum(datum[:dims] * self.pc) > 0.0:
				d1l.append(data1[index])
			else:
				d1r.append(data1[index])
		
		self.pathInt = pathInt
		
		# Need to test for singularities before branching (bleh)
		# since singularities can't of course be partitioned.
		leftnonsingular = self.subset_is_nonsingular(d0l, "d0l", d0r) \
		              and self.subset_is_nonsingular(d1l, "d1l", d1r) 
		rghtnonsingular = self.subset_is_nonsingular(d0r, "d0r", d0l) \
		              and self.subset_is_nonsingular(d1r, "d1r", d1l) 
		
		# Recurse and store - the children become either Xamrt items (if branch) or arrays (if leaf)
		if (maxdepth != 1) and leftnonsingular and (len(d0l) > sizethresh) and (len(d1l) > sizethresh):
			self.kidl = self.__class__(d0l, d1l, dims, sizethresh, maxdepth-1, (pathInt << 1)) 
		else:
			self.kidl = [d0l, d1l]
		if (maxdepth != 1) and rghtnonsingular and (len(d0r) > sizethresh) and (len(d1r) > sizethresh):
			self.kidr = self.__class__(d0r, d1r, dims, sizethresh, maxdepth-1, (pathInt << 1) + 1)
		else:
			self.kidr = [d0r, d1r]

	# Depth-first recursive method to prune the tree
	def prune(self, thresh=0.5):
		if self.lbranches():
			self.kidl.prune(thresh)
			if   (self.kidl.kidl.__class__  != self.__class__) \
			 and (self.kidl.kidr.__class__ != self.__class__):
				# this child has two leaves under it, so we decide whether to merge them or not.
				if self.kidl.stabilitytest() < thresh:
					#print "merging node (%d %d|%d %d)" % (len(self.kidl.kidl[0]), len(self.kidl.kidl[1]), len(self.kidl.kidr[0]), len(self.kidl.kidr[1]))
					self.kidl = self.kidl.items()
					
		if self.rbranches():
			self.kidr.prune(thresh)
			if   (self.kidr.kidl.__class__  != self.__class__) \
			 and (self.kidr.kidr.__class__ != self.__class__):
				# this child has two leaves under it, so we decide whether to merge them or not.
				if self.kidr.stabilitytest() < thresh:
					#print "merging node (%d %d|%d %d)" % (len(self.kidr.kidl[0]), len(self.kidr.kidl[1]), len(self.kidr.kidr[0]), len(self.kidr.kidr[1]))
					self.kidr = self.kidr.items()

	# Jackknife test for how stable the split (i.e. the principal component axis) is
	def stabilitytest(self):
		td = self.items()
		# from Xamrt import *; p = Xamrt.processcsv("/Users/dan/backups/_mysvn_/stored_docs/dataoutput/MappedSource/mixedvoicedata.csv", "/Users/dan/backups/_mysvn_/stored_docs/dataoutput/MappedSource/MappedSynthSuperSimple_tcbuf.csv", 14, maxdepth=12, plot=False, prune=0, startrow1=1, startrow2=0)
		# p.prune()
		td = [map(lambda datum: datum[:self.dims] - self.centre0, td[0]), \
			      map(lambda datum: datum[:self.dims] - self.centre1, td[1])]
		
		dist0 = 0.0
		for i in range(len(td[0])):
			oneout = td[0][:]
			del oneout[i]
			tpc = pcdual(array(oneout), array(td[1]), self.dims)
			adist = abs(dot(tpc, self.pc))
			dist0 = dist0 + adist
		
		dist1 = 0.0
		for i in range(len(td[1])):
			oneout = td[1][:]
			del oneout[i]
			tpc = pcdual(array(td[1]), array(oneout), self.dims)
			adist = abs(dot(tpc, self.pc))
			dist1 = dist1 + adist
		
		val = ((dist0 / len(td[0])) + \
		       (dist1 / len(td[1])) ) * 0.5
		return val

	# VALIDATION: double-check that every datum gets mapped to a leaf that contains itself
	# This *must* be fed the data (data0, data1) that was used to build the tree, that's the only meaningful use of this.
	# "inexact" argument can be set to True to accommodate rounding error (necessary if you've used scaling)
	def validate(self, data0, data1, inexact=False):
		thresh = 1e-10
		for datum in data0:
			leaf = self.getleaf(self.classify(datum, 0))
			found = False
			for row in leaf[0]:
				if all(row==datum) or (inexact and all(abs(row-datum) < thresh)):
					found = True
					break
			if not(found):
				print "Validation FAIL: datum not found in leaf node"
				print datum
				print leaf[0]
				print map(lambda row: row-datum, leaf[0])
				print map(lambda row: abs(row-datum) < thresh, leaf[0])
				return False
		for datum in data1:
			leaf = self.getleaf(self.classify(datum, 1))
			found = False
			for row in leaf[1]:
				if all(row==datum) or (inexact and all(abs(row-datum) < thresh)):
					found = True
					break
			if not(found):
				print "Validation FAIL: datum not found in leaf node"
				print datum
				print leaf[1]
				print map(lambda row: row-datum, leaf[1])
				print map(lambda row: abs(row-datum) < thresh, leaf[1])
				return False
		return True



	# Do not supply the three arguments yourself - they're for recursion
	def meandepth(self, curdepth=0, runningsum=0, runningcount=0):
		# Recurse left
		if self.lbranches():
			[runningsum, runningcount] = self.kidl.meandepth(curdepth + 1, runningsum, runningcount)
		else:
			runningsum = runningsum + curdepth + 1
			runningcount = runningcount + 1
		# Recurse right
		if self.rbranches():
			[runningsum, runningcount] = self.kidr.meandepth(curdepth + 1, runningsum, runningcount)
		else:
			runningsum = runningsum + curdepth + 1
			runningcount = runningcount + 1
		# Back up the tree, or output the result if finished
		if curdepth==0:
			return float(runningsum)/float(runningcount)
		else:
			return [runningsum, runningcount]
	
	# Do not supply the arguments yourself - they're for recursion
	def maxdepth(self, curdepth=0):
		curdepth = curdepth + 1
		if self.lbranches():
			curdepth_l = self.kidl.maxdepth(curdepth)
		else:
			curdepth_l = curdepth
		if self.rbranches():
			curdepth_r = self.kidr.maxdepth(curdepth)
		else:
			curdepth_r = curdepth
		return max(curdepth_l, curdepth_r)
		 
	
	# Count leaf nodes. Do not supply arguments yourself - they're for recursion
	def numleaves(self, runningcount=0):
		# Recurse left
		if self.lbranches():
			runningcount = self.kidl.numleaves(runningcount)
		else:
			runningcount = runningcount + 1
		# Recurse right
		if self.rbranches():
			runningcount = self.kidr.numleaves(runningcount)
		else:
			runningcount = runningcount + 1
		return runningcount
		
	# Similar to the .clusters method but lumps all the clusters together,
	# returning merely an array holding two lists of the datapoints
	def items(self):
		if self.lbranches():
			l = self.kidl.items()
		else:		
			l = self.kidl
		if self.rbranches():
			r = self.kidr.items()
		else:		
			r = self.kidr
		
		return [l[0] + r[0], l[1] + r[1]]

	# gets the data point arrays from the leaves. returns an array, 
	# each item containing two elements (array of data0, array of data1).
	# maxdepth can be used to merge clusters below that depth.
	# NOTE: the order of the returned clusters is not specified, in particular it's not the same order as the natural ordering of pathInt!
	def clusters(self, maxdepth=Inf):
		if self.lbranches():
			if maxdepth == 1:
				l = [self.kidl.items()]
			else:
				l = self.kidl.clusters(maxdepth - 1)
		else:		
			l = [self.kidl]

		if self.rbranches():
			if maxdepth == 1:
				r = [self.kidr.items()]
			else:
				r = self.kidr.clusters(maxdepth - 1)
		else:		
			r = [self.kidr]

		return l + r

	# Uses clusters() to produce scatter plots in gnuplot
	def scatter(self, maxdepth=Inf, rotate=True):
		from subprocess import Popen
		c = self.clusters(maxdepth)
		if rotate:
			rr = self.pcarot3()
		for which in [0,1]:
			path = '/tmp/py_to_gnuplot_c%i.txt' % which
			f = open(path, 'w')
			if rotate:
				for clus in c:
					for row in clus[which]:
						f.write('\t'.join(map(str, dot(row[:self.dims], rr))) + '\n')
					f.write('\n\n')
			else:
				for clus in c:
					for row in clus[which]:
						f.write('\t'.join(map(str, row[:3])) + '\n')
					f.write('\n\n')
			f.close()
			plotcmd = 'set key off; splot ' + ', '.join(map(lambda i: '\'%s\' index %i with points' % (path, i), range(len(c)))) + '; pause -1'
			Popen([self.gnuplotpath, '-e', plotcmd])

	# Writes TWO data files, each in the format specified in PlaneTree.html
	# ...except in CSV format since I don't know of a way to get python to write float aiffs.
	# Also we'll write out the centroid data, that might be helpful too.
	# Also if you pass in data0 and data1 then it writes out their classifications.
	def write(self, path, data0=[], data1=[], revmap0=[], revmap1=[]):
		path0 = path + '.0.csv'
		path1 = path + '.1.csv'
		path0_c = path + '.cent0.csv'
		path1_c = path + '.cent1.csv'
		fp0 = open(path0, 'w')
		fp1 = open(path1, 'w')
		fp0_c = open(path0_c, 'w')
		fp1_c = open(path1_c, 'w')
		if revmap0:
			path0_r = path + '.trevmap0.csv'
			fp0_r = open(path0_r, 'w')
		else:
			fp0_r = None
		if revmap1:
			path1_r = path + '.trevmap1.csv'
			fp1_r = open(path1_r, 'w')
		else:
			fp1_r = None
		self.__write_breadthfirst(fp0, fp1, fp0_c, fp1_c, data0, data1, revmap0, revmap1, fp0_r, fp1_r)
		fp0.close()
		fp1.close()
		fp0_c.close()
		fp1_c.close()
		if revmap0:
			fp0_r.close()
		if revmap1:
			fp1_r.close()

		if len(data0) != 0:
			path0_c = path + '.paths0.csv'
			path1_c = path + '.paths1.csv'
			fp0_c = open(path0_c, 'w')
			fp1_c = open(path1_c, 'w')
			for datum in data0:
				fp0_c.write(str(self.classify(datum, 0)) + '\n')
			for datum in data1:
				fp1_c.write(str(self.classify(datum, 1)) + '\n')
			fp0_c.close()
			fp1_c.close()


	def __write_breadthfirst(self, fp0, fp1, fp0_c, fp1_c, data0, data1, revmap0, revmap1, fp0_r, fp1_r):
		# We use a FIFO queue (python "deque") to do breadth-first traversal
		# http://en.wikipedia.org/wiki/Breadth-first_search
		# http://docs.python.org/library/collections.html#deque-objects
		
		# Note that we want to output "empty spaces" corresponding to integers which don't represent branch nodes in the tree 
		#(they're either leaves or not-there nodes)
		latestPathInt = 1
		emptyrow = '\t'.join(map(lambda x: '0', range(self.dims * 2 + 2))) + '\n'
		if fp0_r:
			emptyrow_r0  = '\t'.join(map(lambda x: '-2', range(len(revmap0[0])))) + '\n'
			emptyrow_r0b = '\t'.join(map(lambda x: '-3', range(len(revmap0[0])))) + '\n'
		else:
			emptyrow_r0 = None
		if fp1_r:
			emptyrow_r1  = '\t'.join(map(lambda x: '-2', range(len(revmap1[0])))) + '\n'
			emptyrow_r1b = '\t'.join(map(lambda x: '-3', range(len(revmap1[0])))) + '\n'
		else:
			emptyrow_r1 = None
		
		from collections import deque
		fifo = deque([self]) # Enqueue the root node
		
		while len(fifo) != 0:
			anode = fifo.popleft() # Fetch next item to be output
			if anode.__class__ == self.__class__:
				thePathInt = anode.pathInt
				# OK let's construct the data that's going to be written out
				# [offset vector, normal vector, lisl, risl]
				theData0 = list(anode.centre0) + list(anode.pc)
				theData1 = list(anode.centre1) + list(anode.pc)
				if anode.lbranches():
					theData0.append(0)
					theData1.append(0)
				else:
					theData0.append(1)
					theData1.append(1)
				if anode.rbranches():
					theData0.append(0)
					theData1.append(0)
				else:
					theData0.append(1)
					theData1.append(1)
				# Data is constructed, here we turn it to string
				theData0 = '\t'.join(map(str, theData0)) + '\n'
				theData1 = '\t'.join(map(str, theData1)) + '\n'
				# revmap blank for branches:
				theData0_r = emptyrow_r0
				theData1_r = emptyrow_r1
				#theType = "branch"
				# enqueue its kids (they could be a branch or a leaf, doesn't matter - if a leaf then we must also calc + store the pathInt)
				if anode.lbranches():
					fifo.append(anode.kidl)
				else:
					fifo.append(((anode.pathInt << 1)    , anode.kidl))
				if anode.rbranches():
					fifo.append(anode.kidr)
				else:
					fifo.append(((anode.pathInt << 1) | 1, anode.kidr))
			else:
				thePathInt = anode[0]
				theData0 = emptyrow
				theData1 = emptyrow
				#theType = "leaf"

				# For leaf data we also write out the centroids, WITH PATHINT AS FIRST COLUMN
				if len(anode[1][0]) == 0:
					print "Warning, empty leaf0 at %i, writing -1s" % (thePathInt)
					centroid0 = map(lambda x: -1, range(self.dims))
				else:
					centroid0 = mean(map(lambda x: x[:self.dims], anode[1][0]),0)
					if fp0_r:
						# Choose a representative item from within the leaf - TODO better selection than firstest
						repres = anode[1][0][0][:self.dims]
						theData0_r = "UNMATCHED\n"
						for index, row in enumerate(data0):
							if all(abs(row - repres) < 1e-10):
								theData0_r = '\t'.join(map(str, revmap0[index])) + '\n'
								break
				if len(anode[1][1]) == 0:
					print "Warning, empty leaf1 at %i, writing -1s" % (thePathInt)
					centroid1 = map(lambda x: -1, range(self.dims))
				else:
					centroid1 = mean(map(lambda x: x[:self.dims], anode[1][1]),0)
					if fp1_r:
						# Choose a representative item from within the leaf - TODO better selection than firstest
						repres = anode[1][1][0][:self.dims]
						theData1_r = "UNMATCHED\n"
						for index, row in enumerate(data1):
							if all(abs(row - repres) < 1e-10):
								theData1_r = '\t'.join(map(str, revmap1[index])) + '\n'
								break

				fp0_c.write(('%i\t' % (thePathInt))  + '\t'.join(map(str, centroid0)) + '\n')
				fp1_c.write(('%i\t' % (thePathInt))  + '\t'.join(map(str, centroid1)) + '\n')
			
			while latestPathInt != thePathInt:
				#print "%i BLANK" % (latestPathInt)
				fp0.write(emptyrow)
				fp1.write(emptyrow)
				if fp0_r:
					fp0_r.write(emptyrow_r0b)
				if fp1_r:
					fp1_r.write(emptyrow_r1b)
				latestPathInt = latestPathInt + 1
			
			# OK, let's write a row of data!
			#print "%i %s node" % (thePathInt, theType)
			fp0.write(theData0)
			fp1.write(theData1)
			if fp0_r:
				fp0_r.write(theData0_r)
			if fp1_r:
				fp1_r.write(theData1_r)
			
			latestPathInt = latestPathInt + 1
		
	# Find the centroid of every cluster
	def centroids(self, maxdepth=Inf):
		c = self.clusters(maxdepth)
		cent = []
		for clus in c:
			cent.append([mean(map(lambda x: x[:self.dims], clus[0]),0), 
			             mean(map(lambda x: x[:self.dims], clus[1]),0)])
		return cent
	
	# draw a plot with vectors showing how the centroids 'move' (how they match up with each other).
	# (remember that gnuplot 'vectors' style requires [x,y,z,dx,dy,dz])
	def vecmap(self, maxdepth=Inf, rotate=True, writepath=''):
		from subprocess import Popen
		c = self.centroids(maxdepth)
		path = '/tmp/py_to_gnuplot_vecmap.txt'
		f = open(path, 'w')
		if rotate:
			rr = self.pcarot3()
			for clus in c:
				f.write('\t'.join(map(str, list(dot(clus[0], rr))+list(dot(clus[1]-clus[0], rr)))) + '\n')
		else:
			for clus in c:
				f.write('\t'.join(map(str, list(clus[0])+list(clus[1]-clus[0]))) + '\n')
		f.close()
		if self.dims==2:
			plotcmd = 'plot'
		else:
			plotcmd = 'splot'
		plotcmd = '%s \'%s\' with vectors ti "";' % (plotcmd, path)
		if writepath != '':
			plotcmd = plotcmd + 'set term pdf; set output \'%s\'; replot; set term pop; replot;' % (writepath)
		plotcmd = plotcmd + ' pause -1'
		Popen([self.gnuplotpath, '-e', plotcmd])

	# Returns a matrix for randomly projecting the data down to 3D
	def randrot3(self):
		return pca(randn(self.dims, 100))[1][:,:self.dims]
		
	# Returns a matrix for pca-projecting the data down to 3D
	def pcarot3(self):
		return pca(array(self.items()[0]).transpose())[1][:,:self.dims]
	
	# Classify a new datapoint using one of the two distribs' trees 
	# (whichdistrib=0 or 1). Returns an integer indicating which leaf 
	# the datum falls into. The integer's binary representation represents the 
	# location in the tree - each bit storing 0 for left, 1 for right (the root node being the MostSignificantBit 1).
	def classify(self, datum, whichdistrib):
		
		if len(shape(datum)) != 1:
			print "ERROR, input datum must be 1D"
			return False
			
		# ensure numpy, and ensure no extra length
		datum = array(datum[:self.dims])

		return self.__classify(datum, whichdistrib)
	
	def __classify(self, datum, whichdistrib):
		# copy (so we can mangle it)
		cdatum = datum[:]
		
		if whichdistrib == 0:
			cdatum = cdatum -  self.centre0
		else:
			cdatum = cdatum -  self.centre1
		
		# decide whether to go left (0) or right (1)
		if sum(cdatum * self.pc) > 0.0:
			val = 0
			kid = self.kidl
		else:
			val = 1
			kid = self.kidr
		
		if kid.__class__  != self.__class__ :
			return (self.pathInt << 1) + val
		else:
			return kid.__classify(datum, whichdistrib)
	
	# Use an integer as returned by "classify", to retrieve a particular leaf's contents
	def getleaf(self, pathint):
		found = self.getnode(pathint)
		if found.__class__  == self.__class__:
			raise Error("getleaf() recursion error: finished recursion but not reached a leaf! curbitmask %i, pathint %i" % (curbitmask, pathint))
		return found
		
	def getnode(self, pathint):
		# for root node: calc where in the path we're getting our 'first' decision from
		# Slightly geeky method for counting the number of bits we'll need
		curbitmask = 1
		temppathint = pathint >> 2   # offset of 2 just cos that gets the mask in the right place
		while temppathint != 0:
			curbitmask = curbitmask << 1
			temppathint = temppathint >> 1
		return self.__getnode(pathint, curbitmask)

	def __getnode(self, pathint, curbitmask):
		if pathint & curbitmask == 0:
			kid = self.kidl
		else:
			kid = self.kidr
	
		if curbitmask == 1: # no more bits left to analyse, we must have arrived.
			return kid
		else:
			if kid.__class__ == self.__class__:
				return kid.__getnode(pathint, curbitmask >> 1)
			else:
				return None  # This will happen if you ask for a node that doesn't exist in the tree
		
	# Used for undoing variance-normalisation. "muls" is an array of scaling factors e.g. the stdev of each dimension.
	def scale(self, muls):
		self.centre0 = self.centre0 * muls
		self.centre1 = self.centre1 * muls
		self.pc      = self.pc      / muls   # NB divide! note how this should keep constant  sum((inputpoint - centre) * pc)

		if self.lbranches():
			self.kidl.scale(muls)
		else:
			# need to scale up the data contained in the leaf
			self.kidl = map(lambda set: map(lambda datum: datum * muls, set), self.kidl)

		if self.rbranches():
			self.kidr.scale(muls)
		else:
			# need to scale up the data contained in the leaf
			self.kidr = map(lambda set: map(lambda datum: datum * muls, set), self.kidr)
	
	
	# Given two path integers as determined by classify(), this finds the tree distance between them
	@classmethod
	def treedistance(cls, pathInt1, pathInt2):
		bitpos1=0
		bitpos2=0
		# First we find the MSB 1 representing the root node in each one
		while (pathInt1 >> bitpos1) != 0:
			bitpos1 = bitpos1 + 1
		while (pathInt2 >> bitpos2) != 0:
			bitpos2 = bitpos2 + 1
		
		# Then we descend until any of the bits are different
		while (bitpos1 != -1) and (bitpos2 != -1) and \
					(((pathInt1 >> bitpos1) & 1) == ((pathInt2 >> bitpos2) & 1)):
			bitpos1 = bitpos1 - 1
			bitpos2 = bitpos2 - 1

		# The actual descended positions we intend are one more than achieved by the iteration
		bitpos1 = bitpos1 + 1
		bitpos2 = bitpos2 + 1
		
		# Then we sum the number of remaining bits, 
		# i.e. the number of steps needed to go up the tree and back down again
		return bitpos1 + bitpos2
	
	# Return true if the left child is a branch node, false if leaf
	def lbranches(self):
		return self.kidl.__class__ == self.__class__
	# Return true if the right child is a branch node, false if leaf
	def rbranches(self):
		return self.kidr.__class__ == self.__class__
	
	# two trees defined as equal if their partition structure is the same (ignore any data points stored in leaves)
	def equals(self, other):
		return all(self.centre0 == other.centre0) and \
		       all(self.centre1 == other.centre1) and \
		       all(self.pc      == other.pc     ) and \
		       (self.lbranches() == other.lbranches()) and \
		       (self.rbranches() == other.rbranches()) and \
		       (not(self.lbranches()) or self.kidl.equals(other.kidl)) and \
		       (not(self.rbranches()) or self.kidr.equals(other.kidr))
		
		
	# a check used during the recursive construction
	def subset_is_nonsingular(self, arr, name, otherset):
		if len(arr) == 1:
			return False
		elif len(arr) == 0:
			print "Warning: %s is empty. the other:" % (name)
			for row in otherset:
				print row[:self.dims]
			print 'stdev:'
			print array(otherset).std(0)
			print ''
			return False
		else:
			testar = array(arr)[:,:self.dims]
			if sum(testar.max(0) - testar.min(0)) < 0.000000001:
				return False
			return True
		
