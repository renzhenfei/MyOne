package com.example.administrator.one.adapter

import android.text.TextUtils
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.BaseViewHolder
import com.example.administrator.one.R
import com.example.administrator.one.model.ReadEssayModel
import com.example.administrator.one.model.ReadQuestionModel
import com.example.administrator.one.model.ReadSerialModel
import kotlinx.android.synthetic.main.cell_read_page.view.*

class ReadPageListAdapter(data: MutableList<Any>) : BaseQuickAdapter<Any, VH>(R.layout.cell_read_page, data) {

    override fun convert(helper: VH?, item: Any?) {
        when (item) {
            is ReadEssayModel -> {
                helper?.configureEssay(item)
            }
            is ReadSerialModel -> {
                helper?.configureSerial(item)
            }
            is ReadQuestionModel -> {
                helper?.configureQuestion(item)
            }
        }
    }
}

class VH(view: View) : BaseViewHolder(view) {

    private val title: TextView = view.title
    private val author: TextView = view.author
    private val content: TextView = view.content
    private val readType: ImageView = view.readType

    fun configureEssay(essayModel: ReadEssayModel) {
        readType.setImageResource(R.mipmap.icon_read)
        title.text = essayModel.title
        author.visibility = if (TextUtils.isEmpty(essayModel.authors[0].userName)) View.GONE else View.VISIBLE
        author.text = essayModel.authors[0].userName
        content.text = essayModel.guideWord
    }

    fun configureSerial(serialModel: ReadSerialModel) {
        readType.setImageResource(R.mipmap.icon_serial)
        title.text = serialModel.title
        author.visibility = if (TextUtils.isEmpty(serialModel.author.userName)) View.GONE else View.VISIBLE
        author.text = serialModel.author.userName
        content.text = serialModel.excerpt
    }

    fun configureQuestion(questionModel: ReadQuestionModel) {
        readType.setImageResource(R.mipmap.icon_question)
        title.text = questionModel.questionTitle
        author.visibility = if (TextUtils.isEmpty(questionModel.answerTitle)) View.GONE else View.VISIBLE
        author.text = questionModel.answerTitle
        content.text = questionModel.answerContent
    }

}
