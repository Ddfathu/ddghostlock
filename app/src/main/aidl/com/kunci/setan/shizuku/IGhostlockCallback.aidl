package com.kunci.setan.shizuku;

oneway interface IGhostlockCallback {
    void onLog(String line);
    void onComplete(int exitCode);
}
