# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  def index
    @note = Note.new
    all_notes
    if params[:search].present?
      @notes = Note.search(params[:search])
    end
  end

  def edit
    render :index
  end

  def create
    @note = Note.new(note_params)
    all_notes
    if @note.save
      redirect_to notes_path, notice: 'Note was successfully created.'
    else
      render :index
    end
  end

  def update
    all_notes
    if @note.update(note_params)
      redirect_to @note, notice: 'Note was successfully updated.'
      render :index
    else
      render :edit
    end
  end

  def destroy
    @note.destroy
    redirect_to notes_url, notice: 'Note was successfully destroyed.'
  end

  private

  def all_notes
    @notes = Note.all
  end

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :content, :color)
  end
end
