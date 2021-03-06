require 'rails_helper'

RSpec.describe "Tweets", type: :request do

  describe('#index') do
    let(:result) { JSON.parse(response.body) }

    context 'when retrieving tweets' do
      let!(:tweets) { create_list(:tweet, 50) }

      it 'uses the max page size if page size requested is too large' do
        get tweets_path, params: { page: 1, per_page: 50000 }

        expect(result.size).to eq(controller.class::MAX_PAGE_SIZE)
      end

      it 'it receives pagination params and paginates the results accordingly' do
        page_size = 2
        get tweets_path, params: { page: 1, per_page: page_size }

        expect(result.size).to eq(page_size)
      end

      it 'sorts the tweets by most recent' do
        get tweets_path, params: { page: 1, per_page: 10 }

        expected_tweets = tweets.last(10).reverse
        expect(result.map { |tweet| tweet['id'] }).to eq(expected_tweets.pluck(:id))
      end

    end

    context 'when retrieving tweets from a user' do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }

      let!(:tweets) { create_list(:tweet, 10, user: user1) }

      it 'takes the tweets from an specific user given the username' do
        get tweets_path, params: { username: user1.username }

        expect(result.map { |user| user['id'] }).to match_array(user1.tweets.ids)
      end
    end
  end
end
