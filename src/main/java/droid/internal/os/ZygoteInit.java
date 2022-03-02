package droid.internal.os;

import droid.server.SystemServer;
import droid.util.Log;

import java.util.Arrays;

public class ZygoteInit {
    private static final String TAG = "ZygoteInit";

    static {
        System.loadLibrary("droid_zygote");
    }

    public static native int nativeForkSystemServer(int d);
    public static native int nativeGetPid();
    public static native int nativeGetParentPid();
    public static native void nativeExit(int status);

    public static void main(String[] args) {
        Log.i(TAG, "main: " + Arrays.toString(args));
        int pid = ZygoteInit.nativeForkSystemServer(0);
        if (pid == 0) { // child
            SystemServer.main(args);
        } else { // parent
            ZygoteSocketServer.INSTANCE.setReceiver(new ZygoteSocketServer.Receiver() {
                @Override
                public void callback(String msg) {
                    Log.d(TAG, "callback: msg = " + msg);
                }
            });
            ZygoteSocketServer.INSTANCE.open();
        }
    }
}
