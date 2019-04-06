package com.example.administrator.one.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.example.administrator.one.R
import com.example.administrator.one.model.HomePageModel
import com.example.administrator.one.util.CommonUtils
import com.example.administrator.one.util.ImageLoaderUtil
import kotlinx.android.synthetic.main.cell_home_page.view.*

class HomePagerAdapter(data: MutableList<HomePageModel>) : BasePageAdapter<HomePageModel>(data) {

    override fun newView(t: HomePageModel, container: ViewGroup): View? {
        val cell = LayoutInflater.from(container.context).inflate(R.layout.cell_home_page, container, false)
        ImageLoaderUtil.displayImage(container.context, t.imageURL, cell.coverImg)
        cell.volTv.text = t.title
        cell.titleTv.text = t.authorName
        cell.contentTv.text = t.content
        cell.weather.text = "6℃"
        cell.locationTv.text = "杭州"
        cell.dateTime.text = CommonUtils.formatTime(t.makeTime)
        return cell
    }
}