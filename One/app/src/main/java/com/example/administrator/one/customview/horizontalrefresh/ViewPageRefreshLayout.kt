package com.example.administrator.one.customview.horizontalrefresh

import android.content.Context
import android.util.AttributeSet
import android.view.View
import android.view.ViewGroup
import com.example.administrator.one.R

class ViewPageRefreshLayout : ViewGroup {

    private var containerView: View? = null

    constructor(context: Context) : this(context, null)

    constructor(context: Context, attributeSet: AttributeSet?) : this(context, attributeSet, 0)

    constructor(context: Context?, attrs: AttributeSet?, defStyleAttr: Int) : super(context, attrs, defStyleAttr)

    private var rightView: View? = null

    private var leftView: View? = null

    companion object {
        private const val MAX_CHILD_COUNT = 3
        private const val MIN_CHILD_COUNT = 1
        private const val LAYOUT_TYPE_LEFT = 0 //左侧布局
        private const val LAYOUT_TYPE_RIGHT = 1 //右侧布局
        private const val LAYOUT_TYPE_CONTENT = 2 //右侧布局
        private const val LAYOUT_TYPE_NONE = -1 //没有写布局类型 不处理

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
        for (i in 0..childCount) {
            val view = getChildAt(i)
            val type = (view.layoutParams as LayoutParams).type
            when (type) {
                LAYOUT_TYPE_LEFT -> {

                }
                LAYOUT_TYPE_RIGHT -> {

                }
                LAYOUT_TYPE_CONTENT -> {

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
    }

    override fun onLayout(changed: Boolean, l: Int, t: Int, r: Int, b: Int) {
        //不管container的宽高是怎么样的，都设置为match
        containerView?.layout(l, t, r, b)
        //添加左侧和右侧的刷新的view
//        leftView.
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
    interface OnViewAnim {
        fun onNormal()
        fun onHalf()
    }
}