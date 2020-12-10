/*
Gilbert Nouno @ 2014 updated december 2018
always compile with the last max.jar lib to avoid errors when loading

*** Max6 the command line below compiles the file MaxAgJsonOutputReader.java with the needed classpath json-simple-1.1.1.jar and max.jar
*** javac -cp ./json-simple-1.1.1.jar:"/Applications/Max 6.1/Cycling '74/java/lib/max.jar": MaxAgJsonOutputReader.java

# max8 updates for max.jar here :
/Applications/Max.app/Contents/Resources/C74/packages/max-mxj/java-classes/lib/max.jar
# works on December 21st 2018
javac -cp ./json-simple-1.1.1.jar:"/Applications/Max.app/Contents/Resources/C74/packages/max-mxj/java-classes/lib/max.jar": MaxAgJsonOutputReader.java



NB :
* -cp Specify where to find user class files, and (optionally) annotation processors and source files.
* This class path overrides the user class path in the CLASSPATH environment variable.
* If neither CLASSPATH, -cp nor -classpath is specified, the user class path consists of the current directory

*** test/run with (should do nothing and give no error)
*** java -cp ./json-simple-1.1.1.jar:"/Applications/Max 6.1/Cycling '74/java/lib/max.jar": MaxAgJsonOutputReader

create jar file
jar cf MaxAgJsonOutputReader.jar MaxAgJsonOutputReader*.class ./json-simple-1.1.1.jar

run in max by creating "mxj MaxAgJsonOutputReader" or use the help patch !

// class doc :: http://docs.oracle.com/javase/7/docs/api/index-files/index-10.html
*/

// max stuff
/*import com.cycling74.max.Atom;
import com.cycling74.max.MaxClock; // pour le scheduler
import com.cycling74.max.MaxObject;
import com.cycling74.max.MaxSystem;*/ // pour locate file
import com.cycling74.max.*; // get all classes :) !
// standard java io stuff
import java.io.*;
/*import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;*/
/*import java.util.Iterator;
import java.util.jar.*; // use in get compilation date
import java.util.zip.*; // idem*/
import java.net.*;		// idem
import java.util.*; // pour utiliser Map et List avec Iterator sur les objets json , aussi pour la class Date
// org.json.JSONArray stuff, download at : https://code.google.com/p/json-simple/
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/*import java.lang.*;
import java.io.*;
import java.net.*;*/

/*
to know Mapping Between JSON and Java Entities
string	 java.lang.String
number	 java.lang.Number
true|false	 java.lang.Boolean
null	 null
array	 java.util.List
object	 java.util.Map
*/ 

//public class MaxAgJsonOutputReader {
// now MaxAgJsonOutputReader class not only extends MaxObject, it also implements the Executable interface
// For a class to implement Executable the only requirement is that it define an execute() method
public class MaxAgJsonOutputReader extends MaxObject implements Executable {

	// *** data
	private MaxClock clock;
	private String filename = "";//"/Users/nouno/Documents/IRcam/PRod/Ben/Max6/JAva/output.json";
	private JSONParser parser = new JSONParser(); // parser to read a file and parse it to a JsonParser object
	private Object obj; // result of parser
	private JSONObject jsonObject,current_event,it_event; // then casted to a JSON dict
	private JSONArray selectedEvents;
	private JSONArray events;
	private int event_idx,max_event=0;
	//envSlope, timeInScore, transposition, peaktimeSec, sfSkip, envDb, voiceID, powerSeg, duration, simSelects, envDecaySec, midiFromFilename, filename, sfchnls, envAttackSec
	private String sample_buffer;
	private double interval, timeInScore, previousTimeInScore, transposition, sfSkip, duration, midiFromFilename,speed=1,lengthen=0;
	private double attack=1,decay=0,sustain=100,release=1;
	private int adsr_mode=0,last_idx;
	private String buffername="<none>";
	private Atom[] message_list;// = new Atom[2]; // need to give a dimension if declared here without initialization
	private static final Date buildDate = getClassBuildTime(); // see code @ the end

	// add gn 2018
	//private static final Class<?> currentClass = new Object() {}.getClass().getEnclosingClass();				// marche aussi
	//private static final URL resource = currentClass.getResource(currentClass.getSimpleName() + ".class");	// marche aussi
	private String my_class = this.getClass().getSimpleName() +" : ";

	// *** methods
	// define constructor
	MaxAgJsonOutputReader() {
		declareIO(1,1); // 1 inlets and 1+1 outlets (last one is also info outlet)
		// declareAttribute("autobang");
		setInletAssist(0, "read bang info int");
		setOutletAssist(0, "samplor formated message");
		// setOutletAssist(1, "duration");
		// setOutletAssist(2, "timeInScore");
		clock = new MaxClock(this);
		buffername="";	// will be set by the @buffername attribute paradigm
		speed = 1.;
		lengthen = 0;
		declareAttribute("buffername");
		
		post(my_class+"Audio Guide Java Max Player by Gilbert Nouno @ 2014-2018, Audio Guide by Ben Hackbarth @2009-2014-2018, [built "+buildDate+"]");
		//File myFile = new File(resource.getFile());
		//post("URL "+ myFile.getName());//resource.getFileName().toString());
		//post(my_class+"class name " + this.getClass().getSimpleName());										// test Ok
		//post(my_class+"... which is of type " + this.getClass().getSimpleName().getClass());					// test OK
		//post("MAxAgJsonOutputReader built  "+buildDate);

	}

	protected void notifyDeleted() { // called when the mxj object that contains the Java class is deleted in the Max patch
		clock.unset();
	}

	public void read(String jsonfile) { // read jsonfile , parse it and get selectedEvents

		if (jsonfile.length() == 0) {
			jsonfile = MaxSystem.openDialog("Choose a json file generated by audioguide");
		}
		filename = MaxSystem.locateFile(jsonfile); // Get the absolute path of first file named jsonfile found in the MAX search path
		max_event=0;
		//post("debug filename = "+filename+"\n");

		Date d = null;
		//try {
			//d = new Date(new File(filename).lastModified());
		//}
		//catch (IOException e) {e.printStackTrace();}
		//catch (java.net.URISyntaxException ignored) { }
		//post("Date of data file is "+d);
		
		if ((filename != null) && (filename.length() > 0)) {
			max_event=0;
			try {
				obj = parser.parse(new FileReader(filename));
				jsonObject = (JSONObject) obj;	
				d = new Date(new File(filename).lastModified());
			}
			//catch (FileNotFoundException e) {e.printStackTrace();}
			catch (IOException e) {e.printStackTrace();} // unreported exception java.io.IOException; must be caught or declared to be thrown
			catch (ParseException e) {e.printStackTrace();} // unreported exception org.json.simple.parser.ParseException; must be caught or declared to be thrown
		selectedEvents = (JSONArray) jsonObject.get("selectedEvents"); // get selectedEvents which is a list of dict
		max_event=selectedEvents.size();
		event_idx=0;
		interval=-1; // pas encore commencé
		clock.unset();
		post(my_class+"Opening "+filename+ " modified on [" +d+ "] , " +max_event+" events were found\n");
		} // endif
		else post(my_class+"No open file, please choose an output.json file generated by audioguide\n");
	}

	public void execute() {
		if (interval >= 0) { // do not fire the very first time
			// list <bang sample offset dur transp amp > triggers a sound //message = "0. buf_lachenmann "+sfSkip+" "+duration+" "+1/speed+" 1."; 
			if (adsr_mode==0) { // fixe attack decay sustain release
				message_list= new Atom[]{Atom.newAtom("adsr"),Atom.newAtom(attack),Atom.newAtom(decay),Atom.newAtom(sustain),Atom.newAtom(release)};
				outlet(0,message_list);
			}
			else if (adsr_mode==1) { // attack duration sustain release
				message_list= new Atom[]{Atom.newAtom("adsr"),Atom.newAtom(attack),Atom.newAtom(duration),Atom.newAtom(sustain),Atom.newAtom(release)};
				outlet(0,message_list);
			}
			else if (adsr_mode==2) { // attack duration+lengthen sustain lengthen
				message_list= new Atom[]{Atom.newAtom("adsr"),Atom.newAtom(attack),Atom.newAtom(duration),Atom.newAtom(sustain),Atom.newAtom(lengthen)};
				outlet(0,message_list);
				duration += lengthen;
			}
			else if (adsr_mode==3) { // attack decay sustain lengthen
				message_list= new Atom[]{Atom.newAtom("adsr"),Atom.newAtom(attack),Atom.newAtom(decay),Atom.newAtom(sustain),Atom.newAtom(lengthen)};
				outlet(0,message_list);
				duration += lengthen;
			}
			// play da sample, message to samplor in respect to the adsr given mode
			message_list = new Atom[] { Atom.newAtom (0.f),Atom.newAtom (sample_buffer),Atom.newAtom (sfSkip),
										Atom.newAtom (duration),Atom.newAtom (1/speed),Atom.newAtom (1.f) }; 
			outlet(0,message_list);
		}
		if (event_idx<max_event) {
			current_event = (JSONObject) selectedEvents.get(event_idx); // if no cast then  found : java.lang.Object , required: org.json.simple.JSONObject
			sample_buffer = (String) current_event.get("filename"); // casted to a file first ! Q : does this creates like new ?
			//File smple_buffer_file = new File(sample_buffer);
			last_idx = sample_buffer.lastIndexOf("/");
			sample_buffer = sample_buffer.substring(last_idx +1);
			//post("sample_buffer "+sample_buffer); 
			//if((buffername=="<none>" || buffername==null) == false) sample_buffer = buffername;

			//if (buffername.equals("<none>")) post("equals is true"); 				// OK test comparaison
			//if (Objects.equals(buffername,"<none>")) post("ok equals"); 			// OK test comparaison

			if (!(buffername.equals("<none>") || buffername.equals(""))) sample_buffer = buffername;	// si buffername est different de <none> et de "" alors on l'utilise
			/*  {
				// just use sample buffer
				// do nothing
			}
			else {
				// use buffername
				sample_buffer = buffername;
			}*/

			//post("sample_buffer "+sample_buffer);
			previousTimeInScore = timeInScore;
			timeInScore = speed * 1000. * (Double) current_event.get("timeInScore"); // time when we play the sample
			duration = speed * 1000 * (Double) current_event.get("duration"); // if speed 0.5 then duration is double and transp is 0.5
			//duration += lengthen; // extra_length in ms
			sfSkip = 1000 * (Double) current_event.get("sfSkip");
			event_idx++; // for next loop
			interval = timeInScore - previousTimeInScore;
			interval = (interval<0) ? 0 : interval;
			clock.delay(interval);
		}
	else
		clock.unset();
	}

	public void speed(double speedness) {
		speed=(speedness>0) ? 1/speedness : 1.;
	}

	public void lengthen(double xtra_len) {
		lengthen=(xtra_len>0) ? xtra_len : 0.;
	}

	public void adsr_mode(int mode) {
		adsr_mode=(mode>=0 && mode <=3) ? mode : 0;
	}

	public void adsr(Atom[] args) {
		Atom a;
		if (args.length ==4){
			if(args[0].isFloat()) {attack = args[0].getFloat();}
			if(args[0].isInt()) {attack = (float)args[0].getInt();}

			if(args[1].isFloat()) {decay = args[1].getFloat();}
			if(args[1].isInt()) {decay = (float)args[1].getInt();}

			if(args[2].isFloat()) {sustain = args[2].getFloat();}
			if(args[2].isInt()) {sustain = (float)args[2].getInt();}

			if(args[3].isFloat()) {release = args[3].getFloat();}
			if(args[3].isInt()) {release = (float)args[3].getInt();}


			/*decay = args[1].getFloat();
			sustain = args[2].getFloat();
			release = args[3].getFloat();*/
			attack=(attack>=0.) ? attack : 0.;
			decay=(decay>=0.) ? decay : 0.;
			sustain=(sustain>=0. && sustain<=100) ? sustain : 0.;
			release=(release>=0.) ? release : 0.;
		}
		else {post(my_class+"adst message needs 4 values");}

     	/*for(int i = 0; i < args.length; i++)
     	{
        	a = args[i];
        	if(a.isFloat())
           		post("List element "+i+" is a floating point atom with a value of "+a.getFloat());
        	else if(a.isInt())
           		post("List element "+i+" is an integer atom with a value of "+a.getInt());
        	else if(a.isString())
           		post("List element "+i+" is a String atom with a value of "+a.getString());
		}*/
	}

	public void inlet(int i) { // start/stop to play
		if (i==1)  {
			interval = -1; // so as it does not fire at once
			event_idx=0;
			timeInScore=0;
			clock.delay(0);
		}
		else {
			clock.unset();
			interval = -1; // because we have stoped we can't resume with the same time interval
		}
	}

	/*public void info() {
		info(0);
	}*/

	public void info(int level) { // get quick info and print dictionnary
		/*Map<String, JSONObject> map = (Map<String,JSONObject>)jsonObject.getMap();
		ArrayList<String> list = new ArrayList<String>(map.keySet());
		System.out.println(list);*/
		if (max_event>0)	{
			post(my_class+"keySet : "+jsonObject.keySet()+"\n"); // 
			for(Iterator iterator = jsonObject.keySet().iterator(); iterator.hasNext();)	{
				String key = (String) iterator.next();
	    		// System.out.println(jsonObject.get(key));
	    		//post(my_class+"=====================");
	    		post(my_class+key+" : "+jsonObject.get(key)+"\n");
	    	}
	    	if (level >0) {
	    		int c=0;
				for(Iterator iterator = selectedEvents.iterator(); iterator.hasNext();) { // iteration with forLoop on the selectedEvents
					it_event = (JSONObject) iterator.next(); // current iterated event
					post(my_class+"=====================");
					post(my_class+"event "+ c++ +" : "+it_event);//+"\n");
					for(Iterator iterator_b = it_event.keySet().iterator(); iterator_b.hasNext();) { // iteration forLoop on the keyset of the current iterated event
	    					String key = (String) iterator_b.next(); // get and convert current key
	    					// System.out.println(jsonObject.get(key));
	    					post(my_class+"   "+key+" : "+it_event.get(key)+"\n");
	    				}
	    			}
	    		}
    		post(my_class+"buffername set as "+buffername);
    		post(my_class+"lengthen duration in ms = "+lengthen);
    		post(my_class+"adsr atk ="+attack+" ,dec = "+decay+" , sus = "+sustain+" , rel = "+release);
    		post(my_class+"adsr mode = "+adsr_mode);
    	}
    	else post(my_class+"No open file, please choose an output.json file generated by audioguide\n");
    }

	/*
	private void parse_dict() { // deprecated
		//post("\nkeys >>>"+jsonObject.keys());
		selectedEvents = (JSONArray) jsonObject.get("selectedEvents");
		//System.out.print("\n\n selectedEvents.size() >"+selectedEvents.size()+"\n");
		//System.out.print("first element of selectedEvents file is selectedEvents.get(0) >>>"+selectedEvents.get(0)+"\n");
		Iterator<List> iterator = selectedEvents.iterator(); // another way to iterate
			while (iterator.hasNext()) {
				System.out.print("\n in key selectedEvents >>>\n");
				System.out.print(iterator.next());
			}
	}*/

	private static Date getClassBuildTime() { // nice from http://stackoverflow.com/questions/3336392/java-print-time-of-last-compilation
		Date d = null;
		Class<?> currentClass = new Object() {}.getClass().getEnclosingClass();
		URL resource = currentClass.getResource(currentClass.getSimpleName() + ".class");
		if (resource != null) {
			if (resource.getProtocol().equals("file")) {
				try {
					d = new Date(new File(resource.toURI()).lastModified());
				}
				catch (java.net.URISyntaxException ignored) { }
			}
			else if (resource.getProtocol().equals("jar")) {
				String path = resource.getPath();
				d = new Date( new File(path.substring(5, path.indexOf("!"))).lastModified() );    
			}
			else if (resource.getProtocol().equals("zip")) {
				String path = resource.getPath();
				File jarFileOnDisk = new File(path.substring(0, path.indexOf("!")));
            	//long jfodLastModifiedLong = jarFileOnDisk.lastModified ();
            	//Date jfodLasModifiedDate = new Date(jfodLastModifiedLong);
				try {
					java.util.jar.JarFile jf = new java.util.jar.JarFile (jarFileOnDisk);
                	java.util.zip.ZipEntry ze = jf.getEntry (path.substring(path.indexOf("!") + 2));//Skip the ! and the /
                	long zeTimeLong = ze.getTime ();
                	Date zeTimeDate = new Date(zeTimeLong);
                	d = zeTimeDate;
            	}
            	catch (IOException ignored) { }
            	catch (RuntimeException ignored) { }
        	}
    	}
    	return d;
	}

} // end of class definition

