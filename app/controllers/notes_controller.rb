# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :set_note, only: [ :edit, :update, :destroy ]
  before_action :all_notes

  def index
    @note = Note.new

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
        format.json { render :index, status: :created, location: @note }
      else
        format.html { render :index }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to notes_path, notice: 'Note was successfully updated.' }
        format.json { render :index }
      else
        format.html { render :index }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
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
