# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :set_note, only: %i[edit update destroy]
  before_action :all_notes
  before_action :set_locale

  def index
    @note = Note.new
    @fav = @notes.where(fav: 'true')
    if params[:search].present?
      @notes = Note.search(params[:search])
    end
  end

  def edit; end

  def create
    @note = Note.new(note_params)
    respond_to do |format|
      if @note.save
        format.html { redirect_to notes_path, notice: 'Note was successfully created.' }
        format.json { render json: :index, status: :created, location: @note }
      else
        format.html { render action: 'index' }
        format.js { render 'new_modal_error' }
      end
    end
  end

  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to notes_path, notice: 'Note was successfully updated.' }
        format.json { render json: :index, status: :created, location: @note }
      else
        format.html { render action: 'index' }
        format.js { render 'new_modal_error' }
      end
    end
  end

  def destroy
    @note.destroy
    redirect_to notes_url, notice: 'Note was successfully destroyed.'
  end

  private

  def all_notes
    @notes = Note.all.reverse_order
  end

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :content, :color, :fav)
  end

  def set_locale
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def default_url_options(_options = {})
    { locale: I18n.locale }
  end
end
