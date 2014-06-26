S.configAll({
  "defaultToCurrentScreen" : true,
  "secondsBetweenRepeat" : 0.05,
  "checkDefaultsOnLoad" : true,
  "focusCheckWidthMax" : 3000,
  "windowHintsBackgroundColor" : [50, 53, 58, 0.73],
  "windowHintsDuration" : 7,
  "windowHintsWidth" : 65,
  "windowHintsHeight" : 65,
  "windowHintsFontSize" : 36
});

var laptopMonitor = "0";
var laptopMonitorRes = "1680x1050";
var landscapeMonitor = "1920x1080";
var portraitMonitor = "1080x1920";

var fullSizeWindow = slate.operation("corner", {
  "direction" : "top-left",
  "width" : "screenSizeX",
  "height" : "screenSizeY"
});

var resizeAndCenterWindow = function(widthPercentage) {
  var xPercentageOffset = (100-widthPercentage)/2;
  return S.op("move", {
    "x"      : "screenOriginX+(screenSizeX/100.0*"+xPercentageOffset+")",
    "y"      : "screenOriginY",
    "width"  : "screenSizeX/100.0*"+widthPercentage,
    "height" : "screenSizeY"
  });
};

var resizeAndCenterWindowOps = [
  fullSizeWindow,
  resizeAndCenterWindow(85),
  resizeAndCenterWindow(70),
  resizeAndCenterWindow(63),
  resizeAndCenterWindow(55),
  resizeAndCenterWindow(48),
  resizeAndCenterWindow(40)
];

var quarterScreenWindow = S.op("corner", {
  "direction" : "top-left",
  "width"     : "screenSizeX/2",
  "height"    : "screenSizeY/2"
});

var quarterScreenWindowOps = [
  quarterScreenWindow,
  quarterScreenWindow.dup({ "direction" : "top-right" }),
  quarterScreenWindow.dup({ "direction" : "bottom-right" }),
  quarterScreenWindow.dup({ "direction" : "bottom-left" })
];

var quarterScreenLeftWindowOps = [
  quarterScreenWindow,
  quarterScreenWindow.dup({ "direction" : "bottom-left" })
];

var quarterScreenRightWindowOps = [
  quarterScreenWindow.dup({ "direction" : "top-right" }),
  quarterScreenWindow.dup({ "direction" : "bottom-right" })
];

var splitSplitScreenWindow = S.op("corner", {
  "direction" : "top-left",
  "width"     : "screenSizeX/2",
  "height"    : "0.75*screenSizeY"
});

var splitSplitScreenLeftWindowOps = [
  splitSplitScreenWindow,
  splitSplitScreenWindow.dup({ "direction" : "bottom-left", "height" : "0.25*screenSizeY" })
];

var splitSplitScreenRightWindowOps = [
  splitSplitScreenWindow.dup({ "direction" : "top-right" }),
  splitSplitScreenWindow.dup({ "direction" : "bottom-right", "height" : "0.25*screenSizeY" })
];

var halfWidthScreenWindow = S.op("corner", {
  "direction" : "top-left",
  "width"     : "screenSizeX/2",
  "height"    : "screenSizeY"
});

var halfWidthScreenWindowOps = [
  halfWidthScreenWindow,
  halfWidthScreenWindow.dup({ "direction" : "top-right" })
];

var portraitScreenWindow = S.op("move", {
  "x" : "screenOriginX",
  "y" : "screenOriginY",
  "width"  : "screenSizeX",
  "height" : "screenSizeY*0.32",
  "screen" : portraitMonitor
});

var portraitScreenWindowOps = [
  portraitScreenWindow,
  portraitScreenWindow.dup({ "y" : "screenOriginY+(screenSizeY*0.32)", "height" : "screenSizeY*0.48" }),
  portraitScreenWindow.dup({ "y" : "screenOriginY+(screenSizeY*0.32)", "height" : "screenSizeY*0.58" }),
  portraitScreenWindow.dup({ "y" : "screenOriginY+(screenSizeY*0.32)", "height" : "screenSizeY*0.68" })
];

var appCycleFocus = function(app) {
  var windows = [];
  return function() {
    if(S.app().name() == app) {
      var mainWindowTitle = S.app().mainWindow().title();
      S.app().eachWindow(function(winObj) {
        var title = winObj.title();
        if (!winObj.isMinimizedOrHidden() &&
            title != ""                   &&
            title != mainWindowTitle      &&
            !(windows).some(function(v) { return v.title() == title; })) {
          windows.push(winObj);
        }
      });
      var toFocus = windows.shift();
      if (toFocus) toFocus.focus();
    }
    else {
      windows = [];
      S.op("focus", { "app" : app }).run();
    }
  };
};

// options : { "screenId" : _, "window" : _ }
// using both options is fuzzy in some situations
var focusApp = function(app, options) {
  return function() {
    S.eachApp(function(appObj) {
      if (appObj.name() == app) {
        appObj.eachWindow(function(winObj) {
          if (typeof options.window != 'undefined') {
            var title = winObj.title();
            var windowTitleMatch = new RegExp(options.window, "i");
            if (windowTitleMatch.test(title)) {
              winObj.focus();
            }
          }
          if (typeof options.screenId != 'undefined') {
            if (winObj.screen().id() == options.screenId) {
              winObj.focus();
            }
          }
        });
        S.op("focus", { "app" : app }).run();
      }
    });
  };
};

// dups part of focusApp for now
var focusAppAll = function(app) {
  return function() {
    S.eachApp(function(appObj) {
      if (appObj.name() == app) {
        appObj.eachWindow(function(winObj) {
          // hrm, this log appeared to work around the issue, does slate support timeouts?
          S.log("focusing: " + winObj.title());
          winObj.focus();
        });
      }
    });
  };
};

var commonLayout = {
  "EchofonLite" : {
    "operations" : [
      S.op("corner", {
        "direction" : "top-right",
        "width"     : "0.475*screenSizeX",
        "height"    : "0.7*screenSizeY",
        "screen"    : laptopMonitorRes
      })
    ]
  },
  "Emacs" : {
    "operations" : [
      halfWidthScreenWindowOps[1].dup({ "screen" : landscapeMonitor })],
    "repeat-last" : true
  },
  "Evernote" : {
    "main-first" : true,
    "operations" : [
      S.op("move", {
        "x" : "screenOriginX+(screenSizeX*0.2)",
        "y" : "screenOriginY",
        "width" : "screenSizeX*0.5",
        "height" : "screenSizeY",
        "screen" : landscapeMonitor
      })
    ]
  },
  "Google Chrome" : {
    "operations" : [
      resizeAndCenterWindowOps[4].dup({ "screen" : landscapeMonitor })],
    "repeat-last" : true
  },
  "IntelliJ IDEA" : {
    "operations" : [
      halfWidthScreenWindowOps[0].dup({ "screen" : landscapeMonitor })],
      // resizeAndCenterWindowOps[0].dup({ "screen" : landscapeMonitor })],
    "repeat-last" : true
  },
  "iTerm" : {
    "repeat-last" : true,
    "operations" : [
      splitSplitScreenRightWindowOps[0]
    ]
  },
  "Sublime Text 2" : {
    "operations" : [
      halfWidthScreenWindowOps[0].dup({ "screen" : landscapeMonitor })],
      // resizeAndCenterWindowOps[4].dup({ "screen" : landscapeMonitor })],
    "repeat-last" : true
  },
  "Rdio" : {
    "operations" : [
      S.op("move", {
        "x" : "screenOriginX",
        "y" : "screenOriginY+screenSizeY-windowSizeY",
        "width" : "windowSizeX",
        "height" : "windowSizeY",
        "screen" : portraitMonitor
      })
    ]
  },
  "YoruFukurou" : {
    "operations" : [
      S.op("corner", {
        "direction" : "top-right",
        "width"     : "0.5*screenSizeX",
        "height"    : "0.76*screenSizeY",
        "screen"    : laptopMonitorRes
      })
    ]
  }
};

var twoMonitorLayout = slate.layout("twoMonitorLayout", _.extend(
  {
    "_before_" : {
      "operations" : [
        function() { S.log("_before_ twoMonitorLayout"); },
        S.op("sequence", { "operations" : [
          S.op("shell", { "command" : "/usr/sbin/networksetup -setairportpower en0 off" }),
          // S.op("shell", { "command" : "/Users/dave/opt/brew/bin/blueutil power 1"}),
        ]})
      ]
    },
    "Adium" : {
      "main-first" : true,
      "operations" : [
        S.op("move", {
          "x" : "screenOriginX+(0.2*screenSizeX)",
          "y" : "screenOriginY",
          "width" : "0.6*screenSizeX",
          "height" : "0.8*screenSizeY",
         "screen"    : laptopMonitorRes
        })
      ]
    },
    "Messages" : {
      "operations" : [
        quarterScreenWindowOps[2].dup({
          "screen" : laptopMonitorRes
        })
      ]
    },
    "Rdio" : {
      "main-first" : true,
      "operations" : [
        S.op("corner", {
          "direction" : "bottom-right",
          "screen"    : laptopMonitorRes
        })
      ]
    }
  }, commonLayout));

function rotate(i) {
  return i.slice(1).concat(i[0] || []);
}

var laptopLayout = S.layout("laptopLayout", _.extend({
  "_before_" : {
    "operations" : [
      function() { S.log("_before_ laptopLayout"); },
      S.op("sequence", { "operations" : [
        S.op("shell", { "command" : "/usr/sbin/networksetup -setairportpower en0 on" }),
        // S.op("shell", { "command" : "/Users/dave/opt/brew/bin/blueutil power 0"}),
      ]})
    ]
  },
  "Adium" : {
    "operations" : [
      S.op("corner", {
        "direction" : "top-left",
        "width"     : "0.5*screenSizeX",
        "height"    : "0.7*screenSizeY"
      })
    ]
  },
  "Emacs" : {
    "operations" : [
      halfWidthScreenWindowOps[1]],
    "repeat-last" : true
  },
  "Google Chrome" : {
    "operations" : [
      resizeAndCenterWindowOps[3]],
    "repeat-last" : true
  },
  "IntelliJ IDEA" : {
    "operations" : [
      resizeAndCenterWindowOps[0]],
    "repeat-last" : true
  },
  "Messages" : {
    "operations" : [
      quarterScreenWindowOps[2]
    ]
  }
}, commonLayout));

S.default([laptopMonitorRes, landscapeMonitor], twoMonitorLayout);
S.default(1, laptopLayout);

S.bindAll({
  // Layout Bindings
  //"space:ctrl" : universalLayout,

  // Push Bindings
  // NOTE: some of these may *not* work if you have not removed the expose/spaces/mission control bindings
  // "right:ctrl;shift" : S.op("push", { "direction" : "right", "style" : "bar-resize:screenSizeX/3" }),
  // "left:ctrl;shift"  : S.op("push", { "direction" : "left",  "style" : "bar-resize:screenSizeX/3" }),
  // "up:ctrl;shift"    : S.op("push", { "direction" : "up",    "style" : "bar-resize:screenSizeY/2" }),
  // "down:ctrl;shift"  : S.op("push", { "direction" : "down",  "style" : "bar-resize:screenSizeY/2" }),

  // Focus Bindings
  "home:ctrl"     : S.op("focus", { "direction" : "left"   }),
  "end:ctrl"      : S.op("focus", { "direction" : "right"  }),
  "pageUp:ctrl"   : S.op("focus", { "direction" : "up"     }),
  "pageDown:ctrl" : S.op("focus", { "direction" : "down"   }),
  "/:ctrl"        : S.op("focus", { "direction" : "behind" }),

  // Window Hints
  // "tab:ctrl" : S.op("hint"),

  // Switch currently doesn't work well so I'm commenting it out until I fix it.
  // "tab:cmd" : S.op("switch"),

  // Grid
  // "esc:ctrl" : S.op("grid"),

  // emulate optimal layout, these will evolve as I continue with the slate kool-aid
  "delete:alt;cmd"       : S.op("push", { "direction" : "up", "style" : "center" }),
  "delete:ctrl;alt;cmd"  : S.op("chain", { "operations" : [
    S.op("push", { "direction" : "up", "style" : "center", "screen" : laptopMonitorRes }),
    S.op("push", { "direction" : "up", "style" : "center", "screen" : landscapeMonitor })]}),
  "up:ctrl;cmd"          : S.op("nudge", { "x" : "+0",  "y" : "-10%" }),
  "down:ctrl;cmd"        : S.op("nudge", { "x" : "+0",  "y" : "+10%" }),
  "left:ctrl;cmd"        : S.op("nudge", { "x" : "-10%", "y" : "+0"  }),
  "right:ctrl;cmd"       : S.op("nudge", { "x" : "+10%", "y" : "+0"  }),
  "up:shift;ctrl;cmd"    : S.op("nudge", { "x" : "+0",  "y" : "-20" }),
  "down:shift;ctrl;cmd"  : S.op("nudge", { "x" : "+0",  "y" : "+20" }),
  "left:shift;ctrl;cmd"  : S.op("nudge", { "x" : "-20", "y" : "+0"  }),
  "right:shift;ctrl;cmd" : S.op("nudge", { "x" : "+20", "y" : "+0"  }),
  "pageUp:ctrl;cmd"   : S.op("push", { "direction" : "top"    }),
  "pageDown:ctrl;cmd" : S.op("push", { "direction" : "bottom" }),
  "home:ctrl;cmd"     : S.op("push", { "direction" : "left"   }),
  "end:ctrl;cmd"      : S.op("push", { "direction" : "right"  }),
  "up:ctrl;alt;cmd"     : S.op("resize", { "width" : "+0",  "height" : "-10%" }),
  "down:ctrl;alt;cmd"   : S.op("resize", { "width" : "+0",  "height" : "+10%" }),
  "left:ctrl;alt;cmd"   : S.op("resize", { "width" : "-10%", "height" : "+0"  }),
  "right:ctrl;alt;cmd"  : S.op("resize", { "width" : "+10%", "height" : "+0"  }),
  "end:ctrl;alt;cmd"    : S.op("resize", { "width" : "-10%", "height" : "+0", "anchor" : "bottom-right"   }),
  "home:ctrl;alt;cmd"   : S.op("resize", { "width" : "+10%", "height" : "+0", "anchor" : "bottom-right"   }),
  "pageUp:ctrl;alt;cmd"   : S.op("resize", { "width" : "+0", "height" : "+10%", "anchor" : "bottom-right" }),
  "pageDown:ctrl;alt;cmd" : S.op("resize", { "width" : "+0", "height" : "-10%", "anchor" : "bottom-right" }),
  "up:shift;ctrl;alt;cmd"    : S.op("resize", { "width" : "+0",  "height" : "-2%" }),
  "down:shift;ctrl;alt;cmd"  : S.op("resize", { "width" : "+0",  "height" : "+2%" }),
  "left:shift;ctrl;alt;cmd"  : S.op("resize", { "width" : "-2%", "height" : "+0"  }),
  "right:shift;ctrl;alt;cmd" : S.op("resize", { "width" : "+2%", "height" : "+0"  }),
  "`:ctrl;cmd" : S.op("chain", { "operations" : resizeAndCenterWindowOps }),
  "1:ctrl;cmd" : resizeAndCenterWindowOps[0],
  "2:ctrl;cmd" : resizeAndCenterWindowOps[1],
  "3:ctrl;cmd" : resizeAndCenterWindowOps[2],
  "4:ctrl;cmd" : resizeAndCenterWindowOps[3],
  "5:ctrl;cmd" : resizeAndCenterWindowOps[4],
  "6:ctrl;cmd" : resizeAndCenterWindowOps[5],
  "7:ctrl;cmd" : resizeAndCenterWindowOps[6],
  "2:ctrl"           : halfWidthScreenWindowOps[0],
  "2:shift;ctrl"     : halfWidthScreenWindowOps[1],
  "2:shift;ctrl;cmd" : halfWidthScreenWindowOps[1].dup({ "screen" : laptopMonitorRes }),
  "3:ctrl"       : S.op("chain", { "operations" : splitSplitScreenLeftWindowOps  }),
  "3:shift;ctrl" : S.op("chain", { "operations" : splitSplitScreenRightWindowOps }),
  "4:ctrl"       : S.op("chain", { "operations" : quarterScreenLeftWindowOps  }),
  "4:shift;ctrl" : S.op("chain", { "operations" : quarterScreenRightWindowOps }),

  // focus applications
  "c:ctrl;cmd"       : appCycleFocus("Google Chrome"),
  // "c:shift;ctrl;cmd" : focusApp("Google Chrome", { "screenId" : 0, "window" : "inbox" }),
  "a:ctrl;cmd" : appCycleFocus("Adium"),
  "d:ctrl;cmd" : appCycleFocus("Dash"),
  "e:ctrl;cmd" : appCycleFocus("Evernote"),
  // "f:ctrl;cmd" : appCycleFocus("EchofonLite"),
  "f:ctrl;cmd" : appCycleFocus("Finder"),
  "g:ctrl;cmd" : appCycleFocus("SourceTree"), // appCycleFocus("GitX"),
  "l:ctrl;cmd" : appCycleFocus("Light Table"),
  "m:ctrl;cmd" : appCycleFocus("Messages"),
  "p:ctrl;cmd" : appCycleFocus("Preview"),
  "s:ctrl;cmd" : appCycleFocus("Sublime Text 2"),
  "y:ctrl;cmd" : appCycleFocus("YoruFukurou"),
  "i:ctrl;cmd" : appCycleFocus("iBooks"),
  "t:ctrl;cmd" : appCycleFocus("iTerm"),
  "v:ctrl;cmd" : appCycleFocus("IntelliJ IDEA"),
  "v:shift;ctrl;cmd" : focusAppAll("IntelliJ IDEA"),
  "b:ctrl;cmd" : appCycleFocus("Emacs"),
  "x:ctrl;cmd" : appCycleFocus("Firefox"),
  "r:ctrl;cmd" : S.op("focus", { "app" : "Rdio" }),

  // undo
  "z:ctrl;cmd" : S.op("undo"),

  // testing positioning
  // "w:ctrl;cmd"       : S.op("layout", { "name" : twoMonitorLayout }),
  // "w:shift;ctrl;cmd" : S.op("layout", { "name" : laptopLayout }),

  // reload slate
  "space:ctrl;cmd" : S.op("relaunch")
});

// Test Cases
// S.src(".slate.test", true);
// S.src(".slate.test.js", true);

// events
slate.on("windowOpened", function(event, win) {
  switch (win.app().name()) {
  // case "Google Chrome":
  //   win.doOperation(portraitScreenWindowOps[2]);
  //   break;
  case "Firefox":
    S.log("> Firefox : " + event);
    var r = /^Firebug/;
    if (r.test(win.title())) {
      S.log("> Firefox, firebug");
      win.doOperation(quarterScreenWindowOps[3]);
    }
    else if (win.title() == "HttpFox") {
      S.log("> Firefox, HttpFox");
      win.doOperation(quarterScreenWindowOps[0]);
    }
    else {
      S.log("> Firefox, Other : " + win.title());
      // win.doOperation(halfWidthScreenWindowOps[1]);
    }
    break;
  default:
    break;
  }
});

S.log("-------------- Finished Loading Config --------------");
