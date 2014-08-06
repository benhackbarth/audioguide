import sys, re, util, os

class TerminalController:
    """
    A class that can be used to portably generate formatted output to
    a terminal.  
    
    `TerminalController` defines a set of instance variables whose
    values are initialized to the control sequence necessary to
    perform a given action.  These can be simply included in normal
    output to the terminal:

        >>> term = TerminalController()
        >>> print 'This is '+term.GREEN+'green'+term.NORMAL

    Alternatively, the `render()` method can used, which replaces
    '${action}' with the string required to perform 'action':

        >>> term = TerminalController()
        >>> print term.render('This is ${GREEN}green${NORMAL}')

    If the terminal doesn't support a given action, then the value of
    the corresponding instance variable will be set to ''.  As a
    result, the above code will still work on terminals that do not
    support color, except that their output will not be colored.
    Also, this means that you can test whether the terminal supports a
    given action by simply testing the truth value of the
    corresponding instance variable:

        >>> term = TerminalController()
        >>> if term.CLEAR_SCREEN:
        ...     print 'This terminal supports clearning the screen.'

    Finally, if the width and height of the terminal are known, then
    they will be stored in the `COLS` and `LINES` attributes.
    """

    # Cursor movement:
    BOL = ''             #: Move the cursor to the beginning of the line
    UP = ''              #: Move the cursor up one line
    DOWN = ''            #: Move the cursor down one line
    LEFT = ''            #: Move the cursor left one char
    RIGHT = ''           #: Move the cursor right one char

    # Deletion:
    CLEAR_SCREEN = ''    #: Clear the screen and move to home position
    CLEAR_EOL = ''       #: Clear to the end of the line.
    CLEAR_BOL = ''       #: Clear to the beginning of the line.
    CLEAR_EOS = ''       #: Clear to the end of the screen

    # Output modes:
    BOLD = ''            #: Turn on bold mode
    BLINK = ''           #: Turn on blink mode
    DIM = ''             #: Turn on half-bright mode
    REVERSE = ''         #: Turn on reverse-video mode
    NORMAL = ''          #: Turn off all modes

    # Cursor display:
    HIDE_CURSOR = ''     #: Make the cursor invisible
    SHOW_CURSOR = ''     #: Make the cursor visible

    # Terminal size:
    COLS = None          #: Width of the terminal (None for unknown)
    LINES = None         #: Height of the terminal (None for unknown)

    # Foreground colors:
    BLACK = BLUE = GREEN = CYAN = RED = MAGENTA = YELLOW = WHITE = ''
    
    # Background colors:
    BG_BLACK = BG_BLUE = BG_GREEN = BG_CYAN = ''
    BG_RED = BG_MAGENTA = BG_YELLOW = BG_WHITE = ''
    
    _STRING_CAPABILITIES = """
    BOL=cr UP=cuu1 DOWN=cud1 LEFT=cub1 RIGHT=cuf1
    CLEAR_SCREEN=clear CLEAR_EOL=el CLEAR_BOL=el1 CLEAR_EOS=ed BOLD=bold
    BLINK=blink DIM=dim REVERSE=rev UNDERLINE=smul NORMAL=sgr0
    HIDE_CURSOR=cinvis SHOW_CURSOR=cnorm""".split()
    _COLORS = """BLACK BLUE GREEN CYAN RED MAGENTA YELLOW WHITE""".split()
    _ANSICOLORS = "BLACK RED GREEN YELLOW BLUE MAGENTA CYAN WHITE".split()

    def __init__(self, term_stream=sys.stdout):
        """
        Create a `TerminalController` and initialize its attributes
        with appropriate values for the current terminal.
        `term_stream` is the stream that will be used for terminal
        output; if this stream is not a tty, then the terminal is
        assumed to be a dumb terminal (i.e., have no capabilities).
        """
        # Curses isn't available on all platforms
        try: import curses
        except: return

        # If the stream isn't a tty, then assume it has no capabilities.
        if not hasattr(term_stream, 'isatty'): return
        if not term_stream.isatty(): return

        # Check the terminal type.  If we fail, then assume that the
        # terminal has no capabilities.
        try: curses.setupterm()
        except: return

        # Look up numeric capabilities.
        self.COLS = curses.tigetnum('cols')
        self.LINES = curses.tigetnum('lines')
        
        # Look up string capabilities.
        for capability in self._STRING_CAPABILITIES:
            (attrib, cap_name) = capability.split('=')
            setattr(self, attrib, self._tigetstr(cap_name) or '')

        # Colors
        set_fg = self._tigetstr('setf')
        if set_fg:
            for i,color in zip(range(len(self._COLORS)), self._COLORS):
                setattr(self, color, curses.tparm(set_fg, i) or '')
        set_fg_ansi = self._tigetstr('setaf')
        if set_fg_ansi:
            for i,color in zip(range(len(self._ANSICOLORS)), self._ANSICOLORS):
                setattr(self, color, curses.tparm(set_fg_ansi, i) or '')
        set_bg = self._tigetstr('setb')
        if set_bg:
            for i,color in zip(range(len(self._COLORS)), self._COLORS):
                setattr(self, 'BG_'+color, curses.tparm(set_bg, i) or '')
        set_bg_ansi = self._tigetstr('setab')
        if set_bg_ansi:
            for i,color in zip(range(len(self._ANSICOLORS)), self._ANSICOLORS):
                setattr(self, 'BG_'+color, curses.tparm(set_bg_ansi, i) or '')

    def _tigetstr(self, cap_name):
        # String capabilities can include "delays" of the form "$<2>".
        # For any modern terminal, we should be able to just ignore
        # these, so strip them out.
        import curses
        cap = curses.tigetstr(cap_name) or ''
        return re.sub(r'\$<\d+>[/*]?', '', cap)

    def render(self, template):
        """
        Replace each $-substitutions in the given template string with
        the corresponding terminal control string (if it's defined) or
        '' (if it's not).
        """
        return re.sub(r'\$\$|\${\w+}', self._render_sub, template)

    def _render_sub(self, match):
        s = match.group()
        if s == '$$': return s
        else: return getattr(self, s[2:-1])




class printer:
	def __init__(self, verbosity, optionsPath, pathtologfile, length=74):
		self.updateLength = length
		self.term = TerminalController()
		if not (self.term.CLEAR_EOL and self.term.UP and self.term.BOL):
			raise ValueError("Terminal isn't capable enough -- you should use a simpler progress dispaly.")
		self.v = verbosity
		if pathtologfile == None:
			self.loghandle = None
		else:
			self.loghandle = open(pathtologfile, 'w')
		self.term = TerminalController()
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
	def pnt(self, *args):
		if self.v >= 2: print args
	###############################################
	def startPercentageBar(self, upperLabel='', total=100):
		if self.v == 1 and upperLabel != '':
			print(upperLabel + '...')
			return
		elif self.v == 0: return
		self.maxNumb = float(total)
		self.counter = 0
		self.progress = ProgressBar(self.term, upperLabel, self.updateLength)
		self.file = ''
	###############################################
	def percentageBarNext(self, lowerLabel='', incr=1):
		if self.v < 2: return
		maxlen = self.updateLength-20
		if len(lowerLabel) >=  maxlen:
			writetext = lowerLabel[maxlen*-1:]+(' '*(self.updateLength-len(lowerLabel[maxlen*-1:])))
		else:
			writetext = lowerLabel+(' '*(self.updateLength-len(lowerLabel)))
		self.progress.update(self.counter/(self.maxNumb-1), writetext)
		self.counter += incr
	###############################################
	def percentageBarClose(self, txt="Done."):
		if self.v < 2: return
		self.up(txt)
		self.progress.clear()
		print "\n"
	###############################################
	def up(self, txt):
		txt = txt+(' '*(self.updateLength-len(txt)))
		self.progress.update(self.counter/(self.maxNumb-1), txt)
		print "\n"
	###############################################
	def middleprint(self, string, force=False, colour='CYAN', borderchar='-', cr=True): # MIDDLE print call
		if self.v == 0 and not force: return
		outsides = int(((self.updateLength-len(string)-2)/2.0))*borderchar
		printstr = "${BOLD}${%s}%s %s %s${NORMAL}"%(colour, outsides, str(string), outsides)
		if cr: printstr += '\n'
		self.renderOrLog(self.term.render(printstr))
	###############################################
	def printProgramInfo(self, agversion, force=False):
		self.renderOrLog(self.term.render("${RED}audioguide%s${NORMAL} -> %s"%(agversion, os.path.dirname(__file__))))
		self.renderOrLog(self.term.render("${RED}python%s${NORMAL} -> %s"%(sys.version.split()[0], os.path.abspath(sys.executable))))
	###############################################
	def printDict(self, header, dictObj, valueColour='RED'):
		self.middleprint(header, cr=False)
		for key, val in dictObj.items():
			self.renderOrLog(self.term.render("${BOLD}%s${NORMAL} -> ${%s}%s${NORMAL}"%(str(key), valueColour, str(val))))
	###############################################
	def printListLikeHistogram(self, header, values, valueColour='RED'):
		self.middleprint(header, cr=False)
		for frequency, label in util.histogram(values):
			self.renderOrLog(self.term.render("${BOLD}%s${NORMAL} -> ${%s}%.0f%%${NORMAL}"%(str(label), valueColour, (frequency/float(len(values))*100))))
		self.renderOrLog("\n")
	###############################################
	def renderOrLog(self, string):
		if self.v == 0: self.log(string)
		print(string)
	###############################################
	def pprint(self, string, colour='RED'):
		self.renderOrLog(self.term.render("${%s}%s${NORMAL}"%(colour, str(string))))




class ProgressBar:
    HEADER = '${NORMAL}${NORMAL}%s${NORMAL}\n\n'
    BAR = '%3d%% ${GREEN}[${BOLD}%s%s${NORMAL}${GREEN}]${NORMAL}\n'
    def __init__(self, term, header, PRINT_LENGTH):
        self.term = term
        if not (self.term.CLEAR_EOL and self.term.UP and self.term.BOL):
            raise ValueError("Terminal isn't capable enough -- you "
                             "should use a simpler progress dispaly.")
        self.width = PRINT_LENGTH
        self.bar = term.render(self.BAR)
        self.header = self.term.render(self.HEADER % header.center(self.width))
        self.cleared = 1 #: true if we haven't drawn the bar yet.
        self.update(0, '')

    def update(self, percent, message):
    	if percent > 1: percent = 1 # no printing overages..
        if self.cleared:
            sys.stdout.write(self.header)
            self.cleared = 0
        n = int((self.width-10)*percent)
        sys.stdout.write(
            self.term.BOL + self.term.UP + self.term.CLEAR_EOL +
            (self.bar % (100*percent, '='*n, '-'*(self.width-10-n))) +
            self.term.CLEAR_EOL + '\t' + message)

    def clear(self):
        if not self.cleared: self.cleared = 1


