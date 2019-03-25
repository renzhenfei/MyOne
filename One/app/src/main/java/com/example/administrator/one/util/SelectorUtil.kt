package com.example.administrator.one.util

import android.R
import android.content.Context
import android.content.res.ColorStateList
import android.support.annotation.ColorRes
import android.support.v4.content.ContextCompat

object SelectorUtil {
    /**
     * 生成一个颜色选择器
     *  [context] 上下文
     * @param enableColorId 可用时候的颜色
     * @param unableColorId 不可用时候的颜色
     * @return 颜色选择器 use setTextColor(ColorStateList)
     */
    fun generateColorStateList(context:Context,@ColorRes enableColorId: Int, @ColorRes unableColorId: Int): ColorStateList {
        return ColorStateList(arrayOf(intArrayOf(R.attr.state_checked), // enabled
                intArrayOf(-R.attr.state_checked))// disabled
                , intArrayOf(ContextCompat.getColor(context,enableColorId), ContextCompat.getColor(context,unableColorId)))
    }
}