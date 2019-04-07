package com.example.administrator.one.adapter

import android.support.v4.view.ViewCompat
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import com.example.administrator.one.R
import com.example.administrator.one.common.act.Act2
import com.example.administrator.one.model.HomePageModel
import com.example.administrator.one.util.CommonUtils
import com.example.administrator.one.util.ImageLoaderUtil
import kotlinx.android.synthetic.main.cell_home_page.view.*

class HomePagerAdapter(data: MutableList<HomePageModel>, private val imgClick: Act2<String, ImageView>) : BasePageAdapter<HomePageModel>(data) {

    override fun newView(t: HomePageModel, container: ViewGroup): View? {
        val cell = LayoutInflater.from(container.context).inflate(R.layout.cell_home_page, container, false)
        ImageLoaderUtil.displayImage(container.context, t.imageURL, cell.coverImg)
        cell.coverImg.setOnClickListener { imgClick.act(t.imageURL, cell.coverImg) }
        ViewCompat.setTransitionName(cell.coverImg, t.imageURL)
        cell.volTv.text = t.title
        cell.titleTv.text = t.authorName
        cell.contentTv.text = t.content
        cell.weather.text = "6℃"
        cell.locationTv.text = "杭州"
        cell.dateTime.text = CommonUtils.formatTime(t.makeTime)
        return cell
    }
}