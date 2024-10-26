package com.uniq.ui

import android.content.Context

class Uniq {
    companion object {
        init {
            System.loadLibrary("UNIQ_Library")
            // 프린트
//            println("UNIQ_Library loaded")
        }

        @JvmStatic
        external fun apiInit(context: Context)
    }
}
