package com.example.administrator.one.common.api

data class BaseResponse<out T>(val res: Int, val data: T)