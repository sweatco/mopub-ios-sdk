# Integrating Kiip iOS SDK with MoPub iOS SDK

Follow the integration documentation provided by MoPub on Integrating MoPub iOS SDK into the iOS App.

1. You can download Kiip forked MoPub iOS SDK [here](https://github.com/kiip/mopub-ios-sdk. If you wish to integrate Kiip MoPub Adapter alone get it from [here](https://github.com/kiip/mopub-ios-sdk/tree/master/AdNetworkSupport/Kiip)

2. To use the Kiip, download the Kiip's iOS SDK (docs.kiip.me) and place the framework (KiipSDK.framework) and resource (KiipSDKResources.bundle) files in this folder.

3. Login to app.mopub.com, From Inventory select the app which you like to add.

4. Click "Add an Ad Unit" and choose "Full Screen" and name it as "Kiip Reward Unit". Now click on "Code Integration"  to get MoPub Ad unit Id.

5. Navigate to "Networks" and click on "Add a Network" to add "Custom Native Network". Provide a title as "Kiip Network", make sure the App is listed in "Set Up Your Inventory" section.

6. Add "KPKiipInterstitialCustomEvent" in "Custom Event Class" section.

7. Add {"appKey":"<KIIP_APP_KEY>",
        "appSecret":"<KIIP_APP_SECRET>",
        "momentId":"<KIIP_MOMENT_ID>",  
        "testMode":<true/false>} in "Custom Event Class Data" section. That's it you all done.

8. Use the MoPub Ad unit Id and follow MoPub code integration guide.
 
Congratulations and Thank you for adding Kiip Network





  