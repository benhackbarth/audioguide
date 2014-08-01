import sys

audioguide_lady = '''
          ,)(8)).
        (()))())()).
       (()"````"::= )
       )| _    _ ::= )
      (()(o)/ (o) ?(/)
       )(  c    ( :(/)   --> 
      (( \ .__, ;,/(/)
        ) `.___,'/ (/)
           |    | (/)
         _.'    ,\(/)__
     _.-"   `AG'   (/) ".
   ,"               ^    \\
  /                      |
'''
  
def lady_print(string):
	global audioguide_lady
	string = string.split()
	audioguide_lady_pieces = audioguide_lady.split('\n')
	cnt = 0
	i_cnt = 0
	while cnt < len(audioguide_lady_pieces):
		print audioguide_lady_pieces[cnt], ' '*(29-len(audioguide_lady_pieces[cnt])),
		if cnt > 2:
			text = ''
			while len(string) > i_cnt and len(text) < 40:
				text += string[i_cnt]+' '
				i_cnt += 1
			print text
		else:
			print
		cnt += 1


class printer:
	def __init__(self, verbosity, optionsPath, pathtologfile):
		if pathtologfile == None:
			self.loghandle = None
		else:
			self.loghandle = open(pathtologfile, 'w')
	###############################################
	def log(self, *args):
		if self.loghandle == None: return
		text = ''
		for arg in args:
			text += str(arg)+' '
		self.loghandle.write(text+'\n')
	###############################################
	def logsection(self, name):
		buffer = '-'*(len(name)+1)
		self.loghandle.write('%s\n%s\n%s\n'%(buffer, name, buffer))
	###############################################
	def close(self):
		self.loghandle.close()
	###############################################
	def startPercentageBar(self, upperLabel=None, total=100, length=68):
		self.barTotal = total-1
		self.barBanner = upperLabel
		self.barLength = length-8
		self.totalLength = length
		self.barCnt = 0
	###############################################
	def percentageBarNext(self, lowerLabel=None, incr=1):
		string = '\r'
		#string += '*'*self.totalLength+'\n'
		if self.barBanner != None: string += self.barBanner + '\r'
		percent = self.barCnt/float(self.barTotal)
		filled = int(percent*self.barLength)
		empty = self.barLength-filled
		string += "%s\n[%s%s]  %d%%\r"%(self.barBanner, "="*filled, " "*empty, percent*100)
		if lowerLabel != None: string += lowerLabel + '\r'
		sys.stdout.write(string)
		sys.stdout.flush()
		self.barCnt += incr
	###############################################
	def percentageBarClose(self):
		print "\n"
	###############################################
	def pnt(*args):
		print args[1:]

#for i in range(21):
#    sys.stdout.write('\n')
#    sys.stdout.write("[%-20s] %d%%" % (self.barLength, '='*i, 5*i))
#    sys.stdout.flush()
#    

#############################################################################
#class Printer:
#	def __init__(self, ag_version, VERBOSITY, USE_PROGRESS_BAR, PRINT_LENGTH, logfile): # set up
#		self.updateLength = PRINT_LENGTH
#		self.verbosity = VERBOSITY # edited later by init.py
#		self.currentlyUsingProgBar = False
#		self.term = TerminalController() # open a term controller object for printing colors and prog bar
#		# set up prog bar
#		self.usePb = USE_PROGRESS_BAR
#		self.logfile = logfile
#		if self.logfile != None:
#			import datetime
#			self.logh = open(logfile, 'w')
#			self.logh.write("-----------------------------\nAUDIOGUIDE v %s -- %s"%(ag_version, datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S\n\n\n")))
#		else:
#			self.loghh = None
#
#
#
##	def log(self, *args):
##		if self.logfile == None: return
##		text = '\n\n-----------------------------\n'
##		for arg in args:
##			text += str(arg)+' '
##		self.h.write(text+'\n\n')
#
#	def logsection(self, name):
#		if self.logfile == None: return
#		self.logh.write('\n\n\n-----------------------------\n')
#		self.logh.write('%s\n'%name)
#	
#	def write(self, stuff):
#		if self.logfile == None: return
#		self.logh.write(stuff)
#			
#	def done(self):
#		pass
#		#if self.logfile != None:
#			#self.h.close()
#
#	############################################################################
#	def post(self, *args, **keywords): # print call
#		args = list(args)
#		if not self.currentlyUsingProgBar:
#			level = args[-1]
#			if level > self.verbosity: return # skip if printing threshold is too high
#			printString = listToPrintString(args[0:-1])
#			print self.term.render(printString)
#		else: # for progress bar calls
##			print args
##			print args
##			print args
##			print args
#			if args[0] == None: # just an increment
#				printString = self.file
#			elif keywords.has_key('inc') and keywords['inc']: # then its a filename/increment call
#				printString = listToPrintString(args)
#				self.file = printString
#			else:
#				if len(self.file) != 0: printString = self.file+": "+listToPrintString(args[0:-1])
#				else: printString = listToPrintString(args[0:-1])
##			print printString
##			print printString
##			print printString
#			if not self.usePb:  # if not using Pb
#				self.post(printString, 2)
#			else:
#				try:
#					self.progress.update(self.counter/(self.maxNumb-1), printString)
#					#self.progress.update(self.counter/(self.maxNumb-1), printString)
#				except ZeroDivisionError: pass
#				if keywords.has_key('inc') and keywords['inc']:
#					if keywords.has_key('forceInc') and keywords['forceInc'] != None: 
#						self.counter = keywords['forceInc'] # force value
#					else:
#						self.counter = self.counter+1 # increment
#	############################################################################
#	def barOpen(self, dispTxt, maxNumb):
#		if self.usePb:
#			self.currentlyUsingProgBar = True
#			self.maxNumb = float(maxNumb)
#			self.counter = 0
#			self.file = ''
#			self.progress = ProgressBar(self.term, dispTxt, self.verbosity, self.updateLength)
#		else:
#			self.post(dispTxt, 2)
#	############################################################################
#	def barUp(self, filename, txt, inc=False, forceInc=None):
#		if filename != None: self.file = filename
#		if self.file != '': outText = self.file+": "+txt
#		else: outText = txt
#		if self.usePb:
#			outText = outText+(' '*(self.updateLength-len(outText)))
#			try:
#				self.progress.update(self.counter/(self.maxNumb-1), outText)
#			except ZeroDivisionError: pass
#			if inc:
#				if forceInc != None: 
#					self.counter = force # force value
#				else:
#					self.counter = self.counter+1 # increment
#		else: # if not using Pb
#			self.post(outText, 2)
#	############################################################################
#	def barClose(self, txt):
#		if self.usePb:
#			self.file = ""
#			self.barUp(None, txt)
#			self.progress.clear()
#			self.currentlyUsingProgBar = False
#			self.post('\n\n', 2)
#	############################################################################
#	def middle(self, string, level): # MIDDLE print call
#		if level > self.verbosity: return # skip if printing threshold is too high
#		string = str(string)
#		outsides = int(((self.updateLength-len(string)-2)/2.0))*"-"
#		self.post('${BOLD}${CYAN}'+outsides+" "+string+" "+outsides+'${NORMAL}', level)
#
#############################################################################
#
#
#def listToPrintString(listy):
#	for i in range(len(listy)):
#		listy[i]=str(listy[i])
#	return ' '.join(listy)
#	
#
#
#
#class progBar:
#	def __init__(self, dispTxt, maxNumb, PRINT_LENGTH):
#		self.exists = 1
#		self.updateLength = PRINT_LENGTH
#		self.maxNumb = float(maxNumb)
#		self.counter = 0
#		self.term = TerminalController()
#		self.progress = ProgressBar(self.term, dispTxt, self.verbosity, PRINT_LENGTH)
#		self.file = ''
#	def inc(self, force=None):
#		if force != None: self.counter = force # force value
#		else: self.counter = self.counter+1 # increment
#		if self.counter > self.maxNumb: self.counter = self.maxNumb # limit so no overages
#	def up(self, filename, txt):
#		if not ops.usePb: return
#		if filename != None: self.file = filename
#		if self.file != '': outText = self.file+": "+txt
#		else: outText = txt
#		outText = outText+(' '*(self.updateLength-len(outText)))
#		self.progress.update(self.counter/(self.maxNumb-1), outText)
#	def close(self, txt):
#		self.file = ""
#		self.up(None, txt)
#		self.progress.clear()
#		if ops.usePb: print "\n"
#		self.exists = 0
#
#import sys, re
#
#class TerminalController:
#    """
#    A class that can be used to portably generate formatted output to
#    a terminal.  
#    
#    `TerminalController` defines a set of instance variables whose
#    values are initialized to the control sequence necessary to
#    perform a given action.  These can be simply included in normal
#    output to the terminal:
#
#        >>> term = TerminalController()
#        >>> print 'This is '+term.GREEN+'green'+term.NORMAL
#
#    Alternatively, the `render()` method can used, which replaces
#    '${action}' with the string required to perform 'action':
#
#        >>> term = TerminalController()
#        >>> print term.render('This is ${GREEN}green${NORMAL}')
#
#    If the terminal doesn't support a given action, then the value of
#    the corresponding instance variable will be set to ''.  As a
#    result, the above code will still work on terminals that do not
#    support color, except that their output will not be colored.
#    Also, this means that you can test whether the terminal supports a
#    given action by simply testing the truth value of the
#    corresponding instance variable:
#
#        >>> term = TerminalController()
#        >>> if term.CLEAR_SCREEN:
#        ...     print 'This terminal supports clearning the screen.'
#
#    Finally, if the width and height of the terminal are known, then
#    they will be stored in the `COLS` and `LINES` attributes.
#    """
#    import sys
#
#    # Cursor movement:
#    BOL = ''             #: Move the cursor to the beginning of the line
#    UP = ''              #: Move the cursor up one line
#    DOWN = ''            #: Move the cursor down one line
#    LEFT = ''            #: Move the cursor left one char
#    RIGHT = ''           #: Move the cursor right one char
#
#    # Deletion:
#    CLEAR_SCREEN = ''    #: Clear the screen and move to home position
#    CLEAR_EOL = ''       #: Clear to the end of the line.
#    CLEAR_BOL = ''       #: Clear to the beginning of the line.
#    CLEAR_EOS = ''       #: Clear to the end of the screen
#
#    # Output modes:
#    BOLD = ''            #: Turn on bold mode
#    BLINK = ''           #: Turn on blink mode
#    DIM = ''             #: Turn on half-bright mode
#    REVERSE = ''         #: Turn on reverse-video mode
#    NORMAL = ''          #: Turn off all modes
#
#    # Cursor display:
#    HIDE_CURSOR = ''     #: Make the cursor invisible
#    SHOW_CURSOR = ''     #: Make the cursor visible
#
#    # Terminal size:
#    COLS = None          #: Width of the terminal (None for unknown)
#    LINES = None         #: Height of the terminal (None for unknown)
#
#    # Foreground colors:
#    BLACK = BLUE = GREEN = CYAN = RED = MAGENTA = YELLOW = WHITE = ''
#    
#    # Background colors:
#    BG_BLACK = BG_BLUE = BG_GREEN = BG_CYAN = ''
#    BG_RED = BG_MAGENTA = BG_YELLOW = BG_WHITE = ''
#    
#    _STRING_CAPABILITIES = """
#    BOL=cr UP=cuu1 DOWN=cud1 LEFT=cub1 RIGHT=cuf1
#    CLEAR_SCREEN=clear CLEAR_EOL=el CLEAR_BOL=el1 CLEAR_EOS=ed BOLD=bold
#    BLINK=blink DIM=dim REVERSE=rev UNDERLINE=smul NORMAL=sgr0
#    HIDE_CURSOR=cinvis SHOW_CURSOR=cnorm""".split()
#    _COLORS = """BLACK BLUE GREEN CYAN RED MAGENTA YELLOW WHITE""".split()
#    _ANSICOLORS = "BLACK RED GREEN YELLOW BLUE MAGENTA CYAN WHITE".split()
#
#    def __init__(self, term_stream=sys.stdout):
#        """
#        Create a `TerminalController` and initialize its attributes
#        with appropriate values for the current terminal.
#        `term_stream` is the stream that will be used for terminal
#        output; if this stream is not a tty, then the terminal is
#        assumed to be a dumb terminal (i.e., have no capabilities).
#        """
#        # Curses isn't available on all platforms
#        try: import curses
#        except: return
#
#        # If the stream isn't a tty, then assume it has no capabilities.
#        if not hasattr(term_stream, 'isatty'): return
#        if not term_stream.isatty(): return
#
#        # Check the terminal type.  If we fail, then assume that the
#        # terminal has no capabilities.
#        try: curses.setupterm()
#        except: return
#
#        # Look up numeric capabilities.
#        self.COLS = curses.tigetnum('cols')
#        self.LINES = curses.tigetnum('lines')
#        
#        # Look up string capabilities.
#        for capability in self._STRING_CAPABILITIES:
#            (attrib, cap_name) = capability.split('=')
#            setattr(self, attrib, self._tigetstr(cap_name) or '')
#
#        # Colors
#        set_fg = self._tigetstr('setf')
#        if set_fg:
#            for i,color in zip(range(len(self._COLORS)), self._COLORS):
#                setattr(self, color, curses.tparm(set_fg, i) or '')
#        set_fg_ansi = self._tigetstr('setaf')
#        if set_fg_ansi:
#            for i,color in zip(range(len(self._ANSICOLORS)), self._ANSICOLORS):
#                setattr(self, color, curses.tparm(set_fg_ansi, i) or '')
#        set_bg = self._tigetstr('setb')
#        if set_bg:
#            for i,color in zip(range(len(self._COLORS)), self._COLORS):
#                setattr(self, 'BG_'+color, curses.tparm(set_bg, i) or '')
#        set_bg_ansi = self._tigetstr('setab')
#        if set_bg_ansi:
#            for i,color in zip(range(len(self._ANSICOLORS)), self._ANSICOLORS):
#                setattr(self, 'BG_'+color, curses.tparm(set_bg_ansi, i) or '')
#
#    def _tigetstr(self, cap_name):
#        # String capabilities can include "delays" of the form "$<2>".
#        # For any modern terminal, we should be able to just ignore
#        # these, so strip them out.
#        import curses
#        cap = curses.tigetstr(cap_name) or ''
#        return re.sub(r'\$<\d+>[/*]?', '', cap)
#
#    def render(self, template):
#        """
#        Replace each $-substitutions in the given template string with
#        the corresponding terminal control string (if it's defined) or
#        '' (if it's not).
#        """
#        return re.sub(r'\$\$|\${\w+}', self._render_sub, template)
#
#    def _render_sub(self, match):
#        s = match.group()
#        if s == '$$': return s
#        else: return getattr(self, s[2:-1])
#
########################################################################
## Example use case: progress bar
########################################################################
#
#class ProgressBar:
#    HEADER = '${NORMAL}${NORMAL}%s${NORMAL}\n\n'
##   HEADER = '${BOLD}${CYAN}%s${NORMAL}\n\n'
#    BAR = '%3d%% ${GREEN}[${BOLD}%s%s${NORMAL}${GREEN}]${NORMAL}\n'
#
#    def __init__(self, term, header, verbosity, PRINT_LENGTH):
#        self.term = term
#        self.verbosity = verbosity
#        if not (self.term.CLEAR_EOL and self.term.UP and self.term.BOL):
#            raise ValueError("Terminal isn't capable enough -- you "
#                             "should use a simpler progress dispaly.")
#        self.width = PRINT_LENGTH
#        self.bar = term.render(self.BAR)
#        self.header = self.term.render(self.HEADER % header.center(self.width))
#        self.cleared = 1 #: true if we haven't drawn the bar yet.
#        self.update(0, '')
#
#    def update(self, percent, message):
#    	if percent > 1: percent = 1 # no printing overages..
#        if self.verbosity <= 1: return
#        if self.cleared:
#            sys.stdout.write(self.header)
#            self.cleared = 0
#        n = int((self.width-10)*percent)
#        sys.stdout.write(
#            self.term.BOL + self.term.UP + self.term.CLEAR_EOL +
#            (self.bar % (100*percent, '='*n, '-'*(self.width-10-n))) +
#            self.term.CLEAR_EOL + '\t' + message)
#
#    def clear(self):
#        if not self.cleared:
##            sys.stdout.write(self.term.BOL + self.term.CLEAR_EOL +
##                             self.term.UP + self.term.CLEAR_EOL +
##                             self.term.UP + self.term.CLEAR_EOL)
#            self.cleared = 1
