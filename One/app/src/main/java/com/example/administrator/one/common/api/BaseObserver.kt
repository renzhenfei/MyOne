package com.example.administrator.one.common.api

import android.util.Log
import io.reactivex.Observer
import io.reactivex.disposables.Disposable

abstract class BaseObserver<T> : Observer<BaseResponse<T>> {

    companion object {
        const val TAG: String = "BaseObserver"
    }

    override fun onSubscribe(d: Disposable) {
        Log.e(TAG, "onSubscribe")
    }

    override fun onNext(baseResponse: BaseResponse<T>) {
        if (baseResponse.res == 0) {
            onSuccess(baseResponse.data)
        } else {
            onFailure(baseResponse.res)
        }
    }

    override fun onError(e: Throwable) {
        Log.e(TAG, "onError:" + e.message)
    }

    override fun onComplete() {
        Log.e(TAG, "onComplete")
    }

    abstract fun onFailure(code: Int?)

    abstract fun onSuccess(data: T?)

}