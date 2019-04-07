package com.example.administrator.one.util

import android.content.Context
import android.graphics.Canvas
import android.graphics.Paint
import android.graphics.Rect
import android.support.v4.content.ContextCompat
import android.support.v7.widget.LinearLayoutManager
import android.support.v7.widget.RecyclerView
import android.view.View
import com.example.administrator.one.R

class DefaultItemDecoration(context: Context) : RecyclerView.ItemDecoration() {
    private val space = 1
    private val dividerPaint = Paint()

    init {
        dividerPaint.color = ContextCompat.getColor(context, R.color.MLBSeparatorColor)
    }

    override fun onDrawOver(c: Canvas, parent: RecyclerView, state: RecyclerView.State) {
        val childCount = parent.childCount
        if (childCount > 0) {
            val left: Float = parent.paddingLeft.toFloat()
            val right: Float = (parent.width - parent.paddingRight).toFloat()
            (0 until childCount - 1).forEach {
                val view = parent.getChildAt(it)
                val top: Float = view.bottom.toFloat()
                c.drawRect(left, top, right, top + space, dividerPaint)
            }
        }
    }

    override fun getItemOffsets(outRect: Rect, view: View, parent: RecyclerView, state: RecyclerView.State) {
        super.getItemOffsets(outRect, view, parent, state)
        val position = parent.getChildAdapterPosition(view)
        val childCount = parent.adapter?.itemCount
        if (childCount != null) {
            if (parent.layoutManager is LinearLayoutManager && childCount > 0) {
                if (position in 0 until childCount - 1) {
                    outRect.bottom = space
                }
            }
        }
    }
}