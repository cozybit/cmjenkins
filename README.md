# cmbuild

Various build scripts to support CyanogenMod automated build and a repository
mirror.

## How to add a repo to the mirror

0. Disable the repo sync script:

```bash
$ ~/sync_cm/sync_cm -d
-rw-r--r-- 1 cyanogenmod cyanogenmod 0 Apr 21 16:10 /home/cyanogenmod/sync_cm.disabled
>>> Script 'sync_cm' disabled...
```

1. CD to `~/cm/.repo/manifests`
2. Make appropriate modifications to `default.xml`

   For example, moving from a public CM repo, to a private cozybit repo:

    ``` diff
    diff --git a/default.xml b/default.xml
    index 7faae76..9bb3ddd 100644
    --- a/default.xml
    +++ b/default.xml
    @@ -278,7 +278,7 @@
        <project path="hardware/cm" name="CyanogenMod/android_hardware_cm" />
        <project path="hardware/invensense" name="CyanogenMod/android_hardware_invensense" groups="invensense" />
        <project path="hardware/libhardware" name="CyanogenMod/android_hardware_libhardware" groups="pdk" />
    -   <project path="hardware/libhardware_legacy" name="CyanogenMod/android_hardware_libhardware_legacy" groups="pdk" />
    +   <project path="hardware/libhardware_legacy" name="cozybit/android_hardware_libhardware_legacy-pvt" remote="private" groups="pdk" />
        <project path="hardware/msm7k" name="CyanogenMod/android_hardware_msm7k" />
        <project path="hardware/qcom/audio" name="CyanogenMod/android_hardware_qcom_audio" groups="qcom" />
        <project path="hardware/qcom/audio-caf" name="CyanogenMod/android_hardware_qcom_audio-caf" groups="caf" />
    ```

3. Git commit and push, be careful with the `.repo/manifest` dir, it is cloned in a funny state (perhaps HEAD is not pointing at any branch?), so do this manually:

    ```bash
    $ git checkout origin/cm-10.2 -b cm-10.2
    # ... do edits or cherry-pick if you already made the edits ...
    $ git commit -a
    $ git push origin cm-10.2
    ```

4. Move the old .repo dir out of the way: `mv ~/cm/.repo /tmp`
5. Re-init the mirror: `repo init -u https://github.com/cozybit/android-platform.git --mirror -b cm-10.2`
6. Re-enable the `sync_cm` script: `sync_cm -e`
