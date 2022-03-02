import droid.internal.os.ZygoteInit;
import droid.internal.os.ZygoteSocketClient;
import droid.internal.os.ZygoteSocketServer;
import droid.util.Log;

public class Root {
    private static final String TAG = "Root";

    public static void main(String[] args) {
        System.out.println(TAG + "/main(): test run with so lib.");
        Log.d(TAG, "main: test run with log lib.");

        ZygoteInit.main(args);
    }
}