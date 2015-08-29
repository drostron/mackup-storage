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
      halfWidthScreenWindowOps[1].dup({ "screen" : laptopMonitorRes })],
    "repeat-last" : true
  },
  "Firefox" : {
    "operations" : [
      halfWidthScreenWindowOps[0].dup({ "screen" : laptopMonitorRes })],
    "repeat-last" : true
  },
  "IntelliJ IDEA" : {
    "operations" : [
      resizeAndCenterWindowOps[4].dup({ "screen" : landscapeMonitor })],
    "repeat-last" : true
  },
  "iTerm" : {
    "repeat-last" : true,
    "operations" : [
      halfWidthScreenWindowOps[1]
    ]
  },
  "Atom" : {
    "operations" : [
      halfWidthScreenWindowOps[0].dup({ "screen" : laptopMonitorRes })],
    "repeat-last" : true
  },
  "Sublime Text 2" : {
    "operations" : [
      halfWidthScreenWindowOps[0].dup({ "screen" : laptopMonitorRes })],
    "repeat-last" : true
  },
  "Rdio" : {
    "operations" : [
      S.op("move", {
        "x" : "screenOriginX",
        "y" : "screenOriginY+screenSizeY-windowSizeY",
        "width" : "windowSizeX",
        "height" : "windowSizeY",
        "screen" : laptopMonitorRes
      })
    ]
  },
  "YoruFukurou" : {
    "operations" : [
      halfWidthScreenWindowOps[1].dup({ "screen" : laptopMonitorRes })
    ]
  }
};

var twoMonitorLayout = slate.layout("twoMonitorLayout", _.extend(
  {
    "_before_" : {
      "operations" : [
        function() { S.log("_before_ twoMonitorLayout"); },
        S.op("sequence", { "operations" : [
          // S.op("shell", { "command" : "/usr/sbin/networksetup -setairportpower en0 off" }),
          // S.op("shell", { "command" : "/Users/dave/opt/brew/bin/blueutil power 1"}),
        ]})
      ]
    },
    "Adium" : {
      "main-first" : true,
      "operations" : [
        S.op("move", {
          "x" : "screenOriginX+(0.5*screenSizeX)",
          "y" : "screenOriginY",
          "width" : "0.5*screenSizeX",
          "height" : "0.83*screenSizeY",
         "screen"    : laptopMonitorRes
        })
      ]
    },
    "Slack" : {
      "main-first" : true,
      "operations" : [
        S.op("move", {
          "x" : "screenOriginX",
          "y" : "screenOriginY",
          "width" : "0.5*screenSizeX",
          "height" : "0.83*screenSizeY",
         "screen"    : laptopMonitorRes
        })
      ]
    },
    "Gitter" : {
      "main-first" : true,
      "operations" : [
        S.op("move", {
          "x" : "screenOriginX+(0.1*screenSizeX)",
          "y" : "screenOriginY",
          "width" : "0.8*screenSizeX",
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
        // S.op("shell", { "command" : "/usr/sbin/networksetup -setairportpower en0 on" }),
        // S.op("shell", { "command" : "/Users/dave/opt/brew/bin/blueutil power 0"}),
      ]})
    ]
  },
  "Adium" : {
    "operations" : [
      S.op("corner", {
        "direction" : "top-right",
        "width"     : "0.5*screenSizeX",
        "height"    : "0.8*screenSizeY"
      })
    ]
  },
  "Slack" : {
    "operations" : [
      S.op("corner", {
        "direction" : "top-left",
        "width"     : "0.5*screenSizeX",
        "height"    : "0.8*screenSizeY"
      })
    ]
  },
  "Gitter" : {
    "operations" : [
      S.op("corner", {
        "direction" : "top-left",
        "width"     : "0.5*screenSizeX",
        "height"    : "0.8*screenSizeY"
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

  "`:ctrl;cmd" : S.op("chain", { "operations" : resizeAndCenterWindowOps }),

  // undo
  "z:ctrl;cmd" : S.op("undo"),

});

S.log("-------------- Finished Loading Config --------------");
