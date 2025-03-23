// Check if we're using KWin 6. If not, assume it's KWin 5.
const isKWIN6 = typeof workspace.windowList === 'function';

function windowToDesktop(destDesktop) {
    // Get the current window
    var thisWin = workspace[(isKWIN6 ? "activeWindow" : "activeClient")];

    // Check that the desktop number we want to switch to exists first before
    // trying to move the window.
    var numDesktops = isKWIN6 ? workspace.desktops.length : workspace.desktops
    if (destDesktop >= 1 && destDesktop <= numDesktops) {
        var thisDesk = isKWIN6 ? workspace.currentDesktop.x11DesktopNumber : workspace.currentDesktop;
        // If the desktop number does exist, check that the window isn't on all
        // desktops, then move the window and switch desktop.
        if (!thisWin.onAllDesktops) {
            var moveCount = 0;
            // Check if the current desktop is greater or less than the the
            // destination desktop, then calculate the number of desktops to
            // move, moving with the slotWindowToDesktop[Previous/Next] function
            // in a loop as needed.
            // This ensures that the window moves desktops and doesn't seem
            // to cause buggy behaviour.
            if (thisDesk > destDesktop) {
                moveCount = (thisDesk - destDesktop);
                for (var i = 0; i < moveCount; ++i) {
                    workspace.slotWindowToPreviousDesktop();
                }
            } else if (thisDesk < destDesktop) {
                moveCount = (destDesktop - thisDesk);
                for (var i = 0; i < moveCount; ++i) {
                    workspace.slotWindowToNextDesktop();
                }
            } else {
                workspace[(isKWIN6 ? "activeWindow" : "activeClient")] = thisWin;
            }
        }
    }
}

if (registerShortcut) {
    registerShortcut("Move with Window to Desktop 1",
    "Move with Window to Desktop 1",
    "",
    function () { windowToDesktop(1); }
    );
    registerShortcut("Move with Window to Desktop 2",
    "Move with Window to Desktop 2",
    "",
    function () { windowToDesktop(2); }
    );
    registerShortcut("Move with Window to Desktop 3",
    "Move with Window to Desktop 3",
    "",
    function () { windowToDesktop(3); }
    );
    registerShortcut("Move with Window to Desktop 4",
    "Move with Window to Desktop 4",
    "",
    function () { windowToDesktop(4); }
    );
    registerShortcut("Move with Window to Desktop 5",
    "Move with Window to Desktop 5",
    "",
    function () { windowToDesktop(5); }
    );
    registerShortcut("Move with Window to Desktop 6",
    "Move with Window to Desktop 6",
    "",
    function () { windowToDesktop(6); }
    );
    registerShortcut("Move with Window to Desktop 7",
    "Move with Window to Desktop 7",
    "",
    function () { windowToDesktop(7); }
    );
    registerShortcut("Move with Window to Desktop 8",
    "Move with Window to Desktop 8",
    "",
    function () { windowToDesktop(8); }
    );
    registerShortcut("Move with Window to Desktop 9",
    "Move with Window to Desktop 9",
    "",
    function () { windowToDesktop(9); }
    );
    registerShortcut("Move with Window to Desktop 10",
    "Move with Window to Desktop 10",
    "",
    function () { windowToDesktop(10); }
    );
    registerShortcut("Move with Window to Desktop 11",
    "Move with Window to Desktop 11",
    "",
    function () { windowToDesktop(11); }
    );
    registerShortcut("Move with Window to Desktop 12",
    "Move with Window to Desktop 12",
    "",
    function () { windowToDesktop(12); }
    );
    registerShortcut("Move with Window to Desktop 13",
    "Move with Window to Desktop 13",
    "",
    function () { windowToDesktop(13); }
    );
    registerShortcut("Move with Window to Desktop 14",
    "Move with Window to Desktop 14",
    "",
    function () { windowToDesktop(14); }
    );
    registerShortcut("Move with Window to Desktop 15",
    "Move with Window to Desktop 15",
    "",
    function () { windowToDesktop(15); }
    );
    registerShortcut("Move with Window to Desktop 16",
    "Move with Window to Desktop 16",
    "",
    function () { windowToDesktop(16); }
    );
    registerShortcut("Move with Window to Desktop 17",
    "Move with Window to Desktop 17",
    "",
    function () { windowToDesktop(17); }
    );
    registerShortcut("Move with Window to Desktop 18",
    "Move with Window to Desktop 18",
    "",
    function () { windowToDesktop(18); }
    );
    registerShortcut("Move with Window to Desktop 19",
    "Move with Window to Desktop 19",
    "",
    function () { windowToDesktop(19); }
    );
    registerShortcut("Move with Window to Desktop 20",
    "Move with Window to Desktop 20",
    "",
    function () { windowToDesktop(20); }
    );
}
