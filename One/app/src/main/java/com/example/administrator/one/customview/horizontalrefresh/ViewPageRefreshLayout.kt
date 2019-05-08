package com.example.administrator.one.customview.horizontalrefresh

import android.animation.Animator
import android.animation.AnimatorListenerAdapter
import android.animation.ValueAnimator
import android.content.Context
import android.util.AttributeSet
import android.util.Log
import android.view.MotionEvent
import android.view.View
import android.view.ViewGroup
import android.view.animation.DecelerateInterpolator
import com.example.administrator.one.R

class ViewPageRefreshLayout : ViewGroup {

    constructor(context: Context) : this(context, null)

    constructor(context: Context, attributeSet: AttributeSet?) : this(context, attributeSet, 0)

    constructor(context: Context?, attrs: AttributeSet?, defStyleAttr: Int) : super(context, attrs, defStyleAttr)

    private var containerView: View? = null

    private var rightView: View? = null

    private var leftView: View? = null

    private var downX: Float = 0f
    private var downY: Float = 0f
    private var valueAnimator:ValueAnimator? = null

    companion object {
        private const val MAX_CHILD_COUNT = 3
        private const val MIN_CHILD_COUNT = 1
        private const val LAYOUT_TYPE_LEFT = 0 //左侧布局
        private const val LAYOUT_TYPE_RIGHT = 2 //右侧布局
        private const val LAYOUT_TYPE_CONTENT = 4 //右侧布局
        private const val LAYOUT_TYPE_NONE = -1 //没有写布局类型 不处理
        private const val DURATION_SCROLL_BACK = 3_00L

    }

    override fun onFinishInflate() {
        super.onFinishInflate()
        if (childCount < MIN_CHILD_COUNT) {
            throw Exception("should at last has $MIN_CHILD_COUNT child")
        }
        if (childCount == MIN_CHILD_COUNT && (getChildAt(0).layoutParams as LayoutParams).type != LAYOUT_TYPE_CONTENT) {
            throw Exception("the one child's type must be LAYOUT_TYPE_CONTENT")
        }
        if (childCount > MAX_CHILD_COUNT) {
            throw Exception("child count can not large than $MAX_CHILD_COUNT")
        }
        for (i in 0 until childCount) {
            val view = getChildAt(i)
            val type = (view.layoutParams as LayoutParams).type
            when (type) {
                LAYOUT_TYPE_LEFT -> {
                    leftView = view
                }
                LAYOUT_TYPE_RIGHT -> {
                    rightView = view
                }
                LAYOUT_TYPE_CONTENT -> {
                    containerView = view
                }
                LAYOUT_TYPE_NONE -> {
                    removeView(view)
                }
            }
        }
    }

    override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
        super.onMeasure(widthMeasureSpec, heightMeasureSpec)
        measureChildWithMargins(containerView, widthMeasureSpec, 0, heightMeasureSpec, 0)
        measureChildWithMargins(leftView, widthMeasureSpec, 0, heightMeasureSpec, 0)
        measureChildWithMargins(rightView, widthMeasureSpec, 0, heightMeasureSpec, 0)
    }

    override fun onLayout(changed: Boolean, l: Int, t: Int, r: Int, b: Int) {
        //不管container的宽高是怎么样的，都设置为match
        containerView?.layout(l, t, r, b)
        //添加左侧和右侧的刷新的view
        leftView?.let { it.layout(-it.measuredWidth, 0, 0, b) }
        rightView?.let { it.layout(r, 0, it.measuredWidth, b) }
    }

    override fun onInterceptTouchEvent(ev: MotionEvent?): Boolean {
        when(ev?.action){
            MotionEvent.ACTION_DOWN -> {
                downX = ev.x
                downY = ev.y
            }
            MotionEvent.ACTION_MOVE -> {
                if (containerView is OnRefreshLoadmoreable){
                    val able = (containerView as OnRefreshLoadmoreable).onLeftRefreshable()
                    return ev.x - downX > 0 && containerView?.x!! >= 0 && able
                }
            }
        }
        return false
    }

    override fun onTouchEvent(event: MotionEvent?): Boolean {
//        return super.onTouchEvent(event)
        if (valueAnimator != null && valueAnimator?.isRunning!!){
            valueAnimator?.cancel()
        }
        when (event?.action) {
            MotionEvent.ACTION_DOWN -> {
                downX = event.x
                downY = event.y
            }
            MotionEvent.ACTION_MOVE -> {
                //检查边界
                    val moveX = event.x
                    val moveY = event.y
                    val dx = moveX - downX
                    val dy = moveY - downY
                    if (Math.abs(dx) > dy) {
                        moveX(dx)
                    }
                    downX = moveX
                    downY = moveY
                    return true
            }
            MotionEvent.ACTION_UP, MotionEvent.ACTION_CANCEL -> {
                if (leftView?.x!! == 0f){

                }else{
                    scrollBack()
                }
                return true
            }
        }
        return true
    }

    /**
     * 滚到初始位置
     */
    private fun scrollBack() {
        val offsetX = Math.abs(leftView?.x!!) - leftView?.measuredWidth!!
        valueAnimator = ValueAnimator.ofFloat(0f, 1f).apply {
            duration = DURATION_SCROLL_BACK
            interpolator = DecelerateInterpolator()
            var lastScrollX = 0f
            addUpdateListener {
                val value = animatedValue as Float
                val scrollX = offsetX * value
                Log.e("scrollBack", " value = $value scrollX = $scrollX")
                containerView?.x = containerView?.x!! + scrollX - lastScrollX
                leftView?.x = leftView?.left!! + scrollX
                rightView?.x = rightView?.left!! + scrollX
                lastScrollX = scrollX
            }
            addListener(object : AnimatorListenerAdapter() {
                override fun onAnimationEnd(animation: Animator?) {
                    containerView?.x = 0f
                    leftView?.x = (-leftView?.measuredWidth!!).toFloat()
                    rightView?.x = measuredWidth.toFloat()
                    valueAnimator = null
                }
            })
            start()
        }
    }

    override fun checkLayoutParams(p: ViewGroup.LayoutParams?): Boolean {
        return p != null && p is LayoutParams
    }

    override fun generateDefaultLayoutParams(): ViewGroup.LayoutParams {
        return LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.MATCH_PARENT)
    }

    override fun generateLayoutParams(attrs: AttributeSet?): ViewGroup.LayoutParams {
        return LayoutParams(context, attrs)
    }

    override fun generateLayoutParams(p: ViewGroup.LayoutParams?): ViewGroup.LayoutParams {
        return LayoutParams(p)
    }

    fun checkEdge(): Boolean {
        return containerView?.x == 0f
    }

    fun moveX(dx: Float) {
        Log.e("moveX","dx = $dx")
        containerView?.x = containerView?.x!! + dx
        if (containerView?.x!! < 0){
            containerView?.x = 0f
        }else if (containerView?.x!! > leftView?.measuredWidth!!){
            containerView?.x = leftView?.measuredWidth!!.toFloat()
        }
        leftView?.x = leftView?.x!! + dx
        if (leftView?.x!! < -leftView?.measuredWidth!!){
            leftView?.x = (-leftView?.measuredWidth!!).toFloat()
        }else if (leftView?.x!! > 0){
            leftView?.x = 0f
        }
        rightView?.x = rightView?.x!! + dx
        if (rightView?.x!! > measuredWidth + rightView?.measuredWidth!!){
            rightView?.x = (measuredWidth + rightView?.measuredWidth!!).toFloat()
        }else if (rightView?.x!! < measuredWidth - rightView?.measuredWidth!!){
            rightView?.x = (measuredWidth - rightView?.measuredWidth!!).toFloat()
        }
        Log.e("moveX","containerView.x = ${containerView?.x} leftView.x = ${leftView?.x} rightView.x = ${rightView?.x}")
    }

    class LayoutParams : ViewGroup.MarginLayoutParams {

        var type: Int? = LAYOUT_TYPE_NONE

        constructor(width: Int, height: Int) : super(width, height)
        constructor(source: ViewGroup.LayoutParams?) : super(source)

        constructor(context: Context?, attrs: AttributeSet?) : super(context, attrs) {
            context?.theme?.obtainStyledAttributes(attrs, R.styleable.EasyPullLayout_LayoutParams, 0, 0)?.let {
                type = it.getInt(R.styleable.EasyPullLayout_LayoutParams_layout_type, LAYOUT_TYPE_NONE)
            }
        }
    }

    /**
     * 左右两侧的view要实现的接口，主要设置view在合适的时机做动画
     */
    interface OnRefreshLoadmoreable {
        fun onLeftRefreshable(): Boolean
        fun onRightLoadmoreable():Boolean
    }
}