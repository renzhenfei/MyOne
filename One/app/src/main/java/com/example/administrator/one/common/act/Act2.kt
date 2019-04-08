package com.example.administrator.one.common.act

interface Act2<in T1, in T2> {
    fun act(t1: T1, t2: T2)
}