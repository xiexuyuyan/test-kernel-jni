package droid.internal.os;

public enum ZygoteSocketServer {
    INSTANCE;

    static {
        System.loadLibrary("droid_zygote");
    }

    private static native boolean nativeIsOpen();
    private static native int nativeOpen();
    private static native void nativeClose();

    public interface Receiver {
        void callback(String msg);
    }

    private static native void nativeSetOnReceiveCallback(Receiver receiver);

    public void setReceiver(Receiver receiver) {
        nativeSetOnReceiveCallback(receiver);
    }

    public int open() {
        if (!nativeIsOpen()) {
            return nativeOpen();
        }
        return -1;
    }

    public void close() {
        nativeClose();
    }
}
