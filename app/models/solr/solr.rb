# encoding: utf-8
require 'rsolr'
require 'pry'

class Solr::Solr
  attr_accessor :page, :per_page, :results

  def initialize(params_search)
    solr ||= new_connection
    search_query = build_queries(params_search)
    params_page = params_search[:page] ? params_search[:page].try(:to_i) : 1
    # &sort=updated_at+desc&wt=json&indent=true&facet=true&facet.field=category_id
    @response = solr.paginate params_page, PER_PAGE_RECORDS, "select", params: search_query, :method => :post
  end

  def number_found
    @response["response"]["numFound"]
  end

  def result_query
    @response["response"]["docs"]
  end

  def facet_query

  end

  private
  def new_connection
    RSolr.connect :url => SOLR_URL, :open_timeout => TIME_OUT_SOLR, :read_timeout => TIME_OUT_SOLR
  end

  def execute_query(query, params)
    query = query.try(:downcase)
    {:q => "name:(#{query}) OR description:(#{query})"}
  end

  def build_queries(params)
    query = clean_query(params[:search]).try(:to_s).try(:strip).try(:squish)
    query.present? ? execute_query(query, params) : {q: "*:*"}
  end

  def clean_query(query)
    query.gsub(/[\#|\!|\@|\%|\^|\$|\~|\`|\&|\*|\(|\)|\-|\_|\=|\+|\]|\[|\{|\}|\"|\'|\;|\:|\?|\/|\>|\.|\<|\,|\||\\]/, "")
  end

end

