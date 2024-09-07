package com.uniq.ui

import android.content.Context

class Uniq {
    companion object {
        init {
            System.loadLibrary("UNIQ_Library")
        }

        @JvmStatic
        external fun apiInit(context: Context)
    }
}
