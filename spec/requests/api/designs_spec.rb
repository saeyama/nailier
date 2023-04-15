# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Designs API', type: :request do
  let!(:user) { create(:user) }

  describe 'GET /api/designs' do
    it 'デザインの一覧情報をjson形式で正常にHTTPレスポンスを返すことが出来る' do
      sign_in user
      create(:design, :with_child_model, :with_5mg_jpg_image, user:)
      create(:design, title: 'タイダイ', user:)
      get api_designs_path(format: :json)
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['designs'].length).to eq(2)
    end
  end

  describe 'GET /api/designs/:id' do
    it 'デザインの詳細情報をjson形式で正常にHTTPレスポンスを返すことが出来る' do
      sign_in user
      design = create(:design, :with_child_model, :with_5mg_jpg_image, user:)
      get api_design_path(design.id, format: :json)
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['title']).to eq(design.title)
    end
  end

  describe 'POST /api/designs/:id' do
    it 'デザイン登録後、正常にHTTPレスポンスを返すことが出来る' do
      sign_in user
      params = { title: 'ワンカラー', nail_part: 'ハンド' }
      expect { post api_designs_path, params: { design: params } }.to change(Design, :count).by(+1)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PATCH /api/designs/:id' do
    it 'デザイン編集後、正常にHTTPレスポンスを返すことが出来る' do
      sign_in user
      design = create(:design, user:)
      patch api_design_path(design.id), params: { design: { title: 'タイダイ' } }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['data']['title']).to eq('タイダイ')
    end
  end

  describe 'DELETE /api/designs/:id' do
    it 'デザイン削除後、正常にHTTPレスポンスを返すことが出来る' do
      sign_in user
      design = create(:design, user:)
      expect { delete api_design_path(design.id) }.to change(Design, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
