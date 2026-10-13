# Shizuku binds GhostlockUserService by component name and talks over the
# generated AIDL stubs; R8 must keep both sides in release builds.
-keep class com.kunci.setan.shizuku.GhostlockUserService { *; }
-keep interface com.kunci.setan.shizuku.IGhostlockUserService { *; }
-keep interface com.kunci.setan.shizuku.IGhostlockCallback { *; }
-keep class com.kunci.setan.shizuku.IGhostlockUserService$Stub { *; }
-keep class com.kunci.setan.shizuku.IGhostlockCallback$Stub { *; }
