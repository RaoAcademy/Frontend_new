package com.app.raoacademy;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.Uri;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Handler;
import android.util.Log;

import androidx.activity.result.ActivityResultCallback;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.annotation.NonNull;
import android.content.pm.ResolveInfo;
import android.content.pm.PackageManager;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.phonepe.intent.sdk.api.B2BPGRequest;
import com.phonepe.intent.sdk.api.B2BPGRequestBuilder;
import com.phonepe.intent.sdk.api.PhonePeInitException;
import com.phonepe.intent.sdk.api.PhonePe;
import com.phonepe.intent.sdk.api.UPIApplicationInfo;
import  java.util.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "samples.flutter.dev/battery";
    private MethodChannel.Result result;
    B2BPGRequest b2BPGRequest;
    private static final int B2B_PG_REQUEST_CODE = 1409;
    int globalRequestCode = -404, globalResultCode = -404;

    public static final String STREAM = "com.chamelalaboratory.demo.flutter_event_channel/eventChannel";
    private EventChannel.EventSink attachEvent;
    final String TAG_NAME = "From_Native";
    private int count = 1;
    private Handler handler;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            // This method is invoked on the main thread.
                            if (call.method.equals("getUpiApps")) {
                                PhonePe.init(this);
                                try {
                                    List<UPIApplicationInfo> upiApps = PhonePe.getUpiApps();
                                    String json = new ObjectMapper().writeValueAsString(upiApps);

                                    result.success(json);
                                } catch (PhonePeInitException | JsonProcessingException exception) {
                                    result.error("phone pay error", "not implemented", exception);
                                }
                            } else if (call.method.equals("initPayment")) {
                                String string_signature = PhonePe.getPackageSignature();
                                System.out.println("string_signature :: " + string_signature);
                                PhonePe.init(this);
                                String base64 = call.argument("base64");
                                String checksum = call.argument("checksum");
                                String apiEndPoint = call.argument("apiEndPoint");
                                String packageName = call.argument("packageName");

                                System.out.println(base64);
                                System.out.println(checksum);
                                System.out.println(apiEndPoint);
                                globalRequestCode = -200;
                                globalResultCode = -200;

                                b2BPGRequest = new B2BPGRequestBuilder()
                                        .setData(base64)
                                        .setChecksum(checksum)
                                        .setUrl(apiEndPoint)
                                        .build();

                                System.out.println("nnjj" + b2BPGRequest);
                                System.out.println("nnjj" + packageName);



//                                ActivityResultLauncher<String> mGetContent = registerForActivityResult(new ActivityResultContracts.GetContent(),
//                                        new ActivityResultCallback<Uri>() {
//                                            @Override
//                                            public void onActivityResult(Uri uri) {
//                                                // Handle the returned Uri
//                                            }
//                                        });

                                try {
                                    startActivityForResult(PhonePe.getImplicitIntent(
                                            this, b2BPGRequest, packageName), B2B_PG_REQUEST_CODE);
//                                    this.result = result;
//                                    setResult(RESULT_OK, intentParent);
                                    result.success("intent Open");
                                } catch (PhonePeInitException e) {
                                    result.success("intent failed :: " + e);
                                }

                            } else if (call.method.equals("checkPaymentStatus")) {
                                Map<String, String> jsonMap = new HashMap<String, String>();

                                jsonMap.put("request_code", String.valueOf(globalRequestCode));
                                jsonMap.put("result_code", String.valueOf(globalResultCode));
                                try {
                                    String json = new ObjectMapper().writeValueAsString(jsonMap);
                                    result.success(json);
                                } catch (JsonProcessingException e) {
                                    e.printStackTrace();
                                    result.success("Some thing went wrong");
                                }
                            }
                            else if(call.method.equals("intentFlow")){
                                ArrayList < String > upiList = new ArrayList < > ();
                                Uri uri = Uri.parse(String.format("%s://%s", "upi", "pay"));
                                Intent upiUriIntent = new Intent();
                                upiUriIntent.setData(uri);
                                PackageManager packageManager = getApplication().getPackageManager();
                                List < ResolveInfo > resolveInfoList = packageManager.queryIntentActivities(upiUriIntent, PackageManager.MATCH_DEFAULT_ONLY);
                                if (resolveInfoList != null) {
                                    for (ResolveInfo resolveInfo: resolveInfoList) {
                                        upiList.add(resolveInfo.activityInfo.packageName);
                                    }
                                }

                                result.success(upiList);
                            }
                            else {
                                result.notImplemented();
                            }
                        }
                );


        new EventChannel(Objects.requireNonNull(getFlutterEngine()).getDartExecutor(), STREAM).setStreamHandler(
                new EventChannel.StreamHandler() {
                    @Override
                    public void onListen(Object args, final EventChannel.EventSink events) {
                        Log.w("TAG_NAME", "Adding listener");
                        attachEvent = events;
//                        attachEvent.success("percentage");
//                        count = 1;
//                        handler = new Handler();
//                        runnable.run();
                    }

                    @Override
                    public void onCancel(Object args) {
                        Log.w("TAG_NAME", "Cancelling listener");
//                        handler.removeCallbacks(runnable);
//                        handler = null;
//                        count = 1;
                        attachEvent = null;
                        System.out.println("StreamHandler - onCanceled: ");
                    }
                }
        );
    }

//    private final Runnable runnable = new Runnable() {
//        @Override
//        public void run() {
//            int TOTAL_COUNT = 100;
//            if (count > TOTAL_COUNT) {
//                attachEvent.endOfStream();
//            } else {
//                double percentage = ((double) count / TOTAL_COUNT);
//                Log.w("TAG_NAME", "\nParsing From Native:  " + percentage);
//                attachEvent.success(percentage);
//            }
//            count++;
//            handler.postDelayed(this, 200);
//        }
//    };


    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        System.out.println("onActivityResult kkklll" + data);
        System.out.println("onActivityResult 1235" + requestCode);
        System.out.println("onActivityResult ruchit is here" + resultCode);
        System.out.println("onActivityResult ruchit is here" + B2B_PG_REQUEST_CODE);
//        Log.e("TAG", "onActivityResult: " +  );
        super.onActivityResult(requestCode, resultCode, data);
        globalResultCode = resultCode;
        globalRequestCode = requestCode;

        Map<String, String> jsonMap = new HashMap<String, String>();

        jsonMap.put("request_code", String.valueOf(globalRequestCode));
        jsonMap.put("result_code", String.valueOf(globalResultCode));
        try {
            String json = new ObjectMapper().writeValueAsString(jsonMap);
            attachEvent.success(json);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            attachEvent.success("Some thing went wrong");
        }

//        try {
//            if (resultCode != RESULT_CANCELED) {
//                if (requestCode == B2B_PG_REQUEST_CODE) {
//                    System.out.println(b2BPGRequest.getData());
//
//                    result.success("Payment_Success");
//                } else {
//                    System.out.println("failed");
//                    result.success("Payment_Failed");
//                }
//            } else {
//                result.success("Payment_Canceled");
//            }
//        } catch (Exception e) {
//            result.success("Unknown_Error");
//        }
    }
}

