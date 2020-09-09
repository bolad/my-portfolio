class PagesController < ApplicationController
  def home
    @posts = Blog.all
    @skills = Skill.all
    flash.now[:notice] = "I am a sample flash message for the home page"
  end

  def about
  end

  def contact
  end

  def tech_news
    @tweets = SocialMediaTool.twitter_search
  end
end
