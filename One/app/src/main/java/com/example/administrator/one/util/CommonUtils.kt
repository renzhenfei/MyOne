package com.example.administrator.one.util

import android.R
import android.content.Context
import android.content.res.ColorStateList
import android.graphics.drawable.ColorDrawable
import android.graphics.drawable.GradientDrawable
import android.graphics.drawable.StateListDrawable
import android.support.annotation.ColorRes
import android.support.annotation.DrawableRes
import android.support.annotation.NonNull
import com.example.administrator.one.App
import java.text.SimpleDateFormat
import java.util.*

object CommonUtils {

    fun formatTime(normalDateString: String?, pattern: String = "EEE dd MM. yyyy"): String {
        val simpleDateFormat = SimpleDateFormat(pattern, Locale.CHINA)
        val date = SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.CHINA).parse(normalDateString)
        return simpleDateFormat.format(date)
    }

    /**
     * 生成一个颜色选择器
     *
     * @param enableColorId 可用时候的颜色
     * @param unableColorId 不可用时候的颜色
     * @return 颜色选择器 use setTextColor(ColorStateList)
     */
    fun generateColorStateList(@NonNull context: Context,@ColorRes enableColorId: Int, @ColorRes unableColorId: Int): ColorStateList {
        return ColorStateList(arrayOf(intArrayOf(R.attr.state_enabled), // enabled
                intArrayOf(-R.attr.state_enabled))// disabled
                , intArrayOf(context.resources.getColor(enableColorId), context.resources.getColor(unableColorId)))
    }

    /**
     * 生成背景颜色选择器
     *
     * @param normalColorId  普通状态颜色
     * @param anotherColorId 选中状态颜色
     * @return use setBackground()
     */
    fun generateDrawableStateList(@NonNull context: Context,@ColorRes normalColorId: Int, @ColorRes anotherColorId: Int): StateListDrawable {
        val stateListDrawable = StateListDrawable()
        val normalColorDrawable: ColorDrawable
        val anotherColorDrawable: ColorDrawable
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.M) {
            normalColorDrawable = ColorDrawable(context.getColor(normalColorId))
            anotherColorDrawable = ColorDrawable(context.getColor(anotherColorId))
        } else {
            normalColorDrawable = ColorDrawable(context.resources.getColor(normalColorId))
            anotherColorDrawable = ColorDrawable(context.resources.getColor(anotherColorId))
        }
        //按下的
        stateListDrawable.addState(intArrayOf(-android.R.attr.state_pressed, -android.R.attr.state_enabled, -android.R.attr.state_selected), normalColorDrawable)
        stateListDrawable.addState(intArrayOf(android.R.attr.state_pressed, android.R.attr.state_enabled, android.R.attr.state_selected), anotherColorDrawable)

        return stateListDrawable
    }

    /**
     * 生成简单的圆角矩形背景
     *
     * @param bgColor 背景颜色
     * @param radius  圆角半径
     * @return use setBackground()
     */
    fun generateDrawable(@NonNull context: Context,@ColorRes bgColor: Int, radius: Float): GradientDrawable {
        val gradientDrawable = GradientDrawable()
        gradientDrawable.shape = GradientDrawable.RECTANGLE
        gradientDrawable.cornerRadius = radius
        gradientDrawable.setColor(context.resources.getColor(bgColor))
        return gradientDrawable
    }

    /**
     * 生成简单的圆角描边矩形背景
     *
     * @param bgColor     背景颜色
     * @param radius      圆角半径
     * @param strokeWidth 外边距
     * @param strokeColor 外边颜色
     * @return use setBackground()
     */
    fun generateDrawable(@NonNull context: Context,@ColorRes bgColor: Int, radius: Float, strokeWidth: Int, @ColorRes strokeColor: Int): GradientDrawable {
        val gradientDrawable = GradientDrawable()
        gradientDrawable.shape = GradientDrawable.RECTANGLE
        gradientDrawable.cornerRadius = radius
        gradientDrawable.setStroke(strokeWidth, context.resources.getColor(strokeColor))
        gradientDrawable.setColor(context.resources.getColor(bgColor))
        return gradientDrawable
    }


    fun generatorDrawableSelector(@NonNull context: Context,@DrawableRes normalId:Int,@DrawableRes otherId:Int){
        val drawable = StateListDrawable()
        drawable.addState(intArrayOf(android.R.attr.state_selected), context.getDrawable(otherId))
        drawable.addState(intArrayOf(-android.R.attr.state_selected), context.getDrawable(otherId))
        drawable.addState(intArrayOf(), context.getDrawable(normalId))
    }
}