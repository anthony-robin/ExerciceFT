module Admin
  class BlogsController < AdminController
    load_and_authorize_resource

    before_action :set_form,
      only: %i[new create edit update]

    # GET /admin/blogs
    def index
      @blogs = @blogs.with_includes.order_desc.page params[:page]
    end

    # GET /admin/blogs/new
    def new
      @form.model.build_picture
      add_breadcrumb t('.title')
    end

    # POST /admin/blogs
    def create
      save_action :new
    end

    # GET admin/blogs/:id/edit
    def edit
      @form.model.build_picture if @form.picture.nil?
      add_breadcrumb t('.title')
    end

    # PUT /admin/blogs/:id
    # PATCH /admin/blogs/:id
    def update
      save_action :edit
    end

    # DELETE /admin/blogs/:id
    def destroy
      @blog.destroy!
      redirect_to blogs_url, notice: t('.notice')
    end

    private

    def set_form
      @form = BlogForm.new(@blog.new_record? ? current_user.blogs.new : @blog)
    end

    def save_action(action)
      if @form.validate(params[:blog]) && @form.save
        redirect_to category_blog_path(@form.model.category, @form.model), notice: t('.notice')
      else
        render action
      end
    end
  end
end
