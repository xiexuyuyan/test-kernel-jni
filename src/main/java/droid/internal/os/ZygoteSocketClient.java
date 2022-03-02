package droid.internal.os;

public enum ZygoteSocketClient {
    INSTANCE;

    static {
        System.loadLibrary("droid_zygote");
    }

    private static native boolean nativeIsOpen();
    private static native int nativeOpen();
    private static native void nativeClose();
    private static native int nativeSendMessage(String msg);

    public boolean isOpen() {
        return nativeIsOpen();
    }

    public int open() {
        return nativeOpen();
    }

    public void close() {
        nativeClose();
    }

    public int sendMessage(String msg) {
        return nativeSendMessage(msg);
    }
}
