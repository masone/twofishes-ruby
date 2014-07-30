require 'test_helper'

describe Twofishes::Result do

  describe "results" do

    let(:results) { Twofishes::Result.from_response(response) }

    it "should return an Array" do
      assert results.is_a? Array
    end

    it "should return an Array containing Result objects" do
      assert results.first.is_a? Twofishes::Result
    end

  end

  describe "result" do

    let(:result) { Twofishes::Result.new(response['interpretations'].first) }

    it "should return fields from response" do
      assert_equal 'pizza', result.what
      assert_equal 'zürich', result.where
    end

    it "should return fields with nested data" do
      geometry = response['interpretations'].first['feature']['geometry']
      assert_equal geometry, result.feature.geometry.to_hash
    end

    it "should return country_code" do
      assert_equal 'CH', result.country_code
    end

    it "should return name" do
      assert_equal 'Zürich', result.name
    end

    it "should return display_name" do
      assert_equal 'Zürich, Switzerland', result.display_name
    end

    it "should return lat" do
      assert_equal 47.36667, result.lat
    end

    it "should return lng" do
      assert_equal 8.55, result.lng
    end

    it "should return coordinates" do
      assert_equal [47.36667, 8.55], result.coordinates
    end

    it "should return parents" do
      assert result.parents.is_a? Array
      assert result.parents.first.is_a? Twofishes::Result
    end

    it "should rubyfy keys" do
      assert_equal 'Zürich, Switzerland', result.feature.display_name
    end

  end

  def response
    {
        'interpretations' => [
            {
                'what' => "pizza",
                'where' => "zürich",
                'feature' => {
                    'cc' => "CH",
                    'geometry' => {
                        'center' => {
                            'lat' => 47.36667,
                            'lng' => 8.55
                        },
                        'bounds' => {
                            'ne' => {
                                'lat' => 47.4762573242,
                                'lng' => 8.66491889954
                            },
                            'sw' => {
                                'lat' => 47.2704658508,
                                'lng' => 8.44349956512
                            }
                        },
                    },
                    'name' => "Zürich",
                    'displayName' => "Zürich, Switzerland",
                    'woeType' => "7 (TOWN)",
                    'ids' => [
                        {
                            'source' => "geonameid",
                            'id' => "2657896"
                        }
                    ],
                    'names' => [
                        {
                            'name' => "Zürich",
                            'lang' => "hbs",
                            'flags' => []
                        },
                        {
                            'name' => "Zürich",
                            'lang' => "fi",
                            'flags' => []
                        },
                        {
                            'name' => "Zurich",
                            'lang' => "eu",
                            'flags' => []
                        },
                        {
                            'name' => "Zuriko",
                            'lang' => "eo",
                            'flags' => []
                        },
                    ],
                    'highlightedName' => "Zürich, Switzerland",
                    'matchedName' => "Zürich, Switzerland",
                    'id' => "'geonameid' =>2657896",
                    'attributes' => {
                        'adm0cap' => 0,
                        'adm1cap' => 1,
                        'scalerank' => 2,
                        'labelrank' => 7,
                        'natscale' => 200,
                        'population' => 341730
                    },
                    'longId' => "72057594040585832",
                    'longIds' => [
                        "72057594045215586",
                        "72057594040585831"
                    ],
                    'parentIds' => [
                        "72057594040586370",
                        "72057594040585831",
                        "72057594044386734",
                        "72057594045215586"
                    ]
                },
                'parents' => [
                    {
                        'cc' => "CH",
                        'geometry' => {
                            'center' => {
                                'lat' => 47.38283,
                                'lng' => 8.53071
                            },
                            'bounds' => {
                                'ne' => {
                                    'lat' => 47.4013137817,
                                    'lng' => 8.54856395721
                                },
                                'sw' => {
                                    'lat' => 47.3555717468,
                                    'lng' => 8.50832080841
                                }
                            }
                        },
                        'name' => "Zürich",
                        'displayName' => "Zürich, Switzerland",
                        'woeType' => "10 (ADMIN3)",
                        'ids' => [
                            {
                                'source' => "geonameid",
                                'id' => "7287650"
                            }
                        ],
                        'names' => [
                            {
                                'name' => "Zurich",
                                'lang' => "en",
                                'flags' => [
                                    "4 (DEACCENT)",
                                    "1 (PREFERRED)"
                                ]
                            },
                            {
                                'name' => "Zuerich",
                                'lang' => "en",
                                'flags' => [
                                    "4 (DEACCENT)"
                                ]
                            },
                            {
                                'name' => "Zürich",
                                'lang' => "en",
                                'flags' => [
                                    "1 (PREFERRED)"
                                ]
                            }
                        ],
                        'id' => "'geonameid' =>7287650",
                        'attributes' => {
                            'population' => 372857
                        },
                        'longId' => "72057594045215586",
                        'parentIds' => [
                            "72057594040586370",
                            "72057594040585831",
                            "72057594044386734"
                        ]
                    },
                    {
                        'cc' => "CH",
                        'geometry' => {
                            'center' => {
                                'lat' => 47.3711,
                                'lng' => 8.54323
                            },
                            'bounds' => {
                                'ne' => {
                                    'lat' => 47.4762573242,
                                    'lng' => 8.65256977081
                                },
                                'sw' => {
                                    'lat' => 47.2704658508,
                                    'lng' => 8.44349956512
                                }
                            }
                        },
                        'name' => "Bezirk Zürich",
                        'displayName' => "Bezirk Zürich, Switzerland",
                        'woeType' => "9 (ADMIN2)",
                        'ids' => [
                            {
                                'source' => "geonameid",
                                'id' => "6458798"
                            }
                        ],
                        'names' => [
                            {
                                'name' => "Bezirk Zuerich",
                                'lang' => "en",
                                'flags' => [
                                    "4 (DEACCENT)"
                                ]
                            },
                            {
                                'name' => "112",
                                'lang' => "",
                                'flags' => [
                                    "256 (NEVER_DISPLAY)"
                                ]
                            },
                            {
                                'name' => "Bezirk Zurich",
                                'lang' => "en",
                                'flags' => [
                                    "4 (DEACCENT)",
                                    "1 (PREFERRED)"
                                ]
                            },
                            {
                                'name' => "Zürich",
                                'lang' => "de",
                                'flags' => [
                                    "16 (LOCAL_LANG)",
                                    "1 (PREFERRED)"
                                ]
                            },
                            {
                                'name' => "Bezirk Zürich",
                                'lang' => "en",
                                'flags' => [
                                    "1 (PREFERRED)"
                                ]
                            },
                            {
                                'name' => "Zurich",
                                'lang' => "de",
                                'flags' => [
                                    "16 (LOCAL_LANG)",
                                    "4 (DEACCENT)",
                                    "1 (PREFERRED)"
                                ]
                            }
                        ],
                        'id' => "'geonameid' =>6458798",
                        'attributes' => {
                            'population' => 0
                        },
                        'longId' => "72057594044386734",
                        'parentIds' => [
                            "72057594040586370",
                            "72057594040585831"
                        ]
                    },
                    {
                        'cc' => "CH",
                        'geometry' => {
                            'center' => {
                                'lat' => 47.41667,
                                'lng' => 8.66667
                            },
                            'bounds' => {
                                'ne' => {
                                    'lat' => 47.7111091614,
                                    'lng' => 8.9723110199
                                },
                                'sw' => {
                                    'lat' => 47.1419944763,
                                    'lng' => 8.36419963837
                                }
                            }
                        },
                        'name' => "Zurich",
                        'displayName' => "Zurich, Switzerland",
                        'woeType' => "8 (ADMIN1)",
                        'ids' => [
                            {
                                'source' => "geonameid",
                                'id' => "2657895"
                            }
                        ],
                        'names' => [
                            {
                                'name' => "Canton Zurigo",
                                'lang' => "it",
                                'flags' => [
                                    "16 (LOCAL_LANG)",
                                    "1 (PREFERRED)"
                                ]
                            },
                            {
                                'name' => "Kanton Zurich",
                                'lang' => "en",
                                'flags' => [
                                    "4 (DEACCENT)"
                                ]
                            },
                            {
                                'name' => "Zurigo",
                                'lang' => "",
                                'flags' => []
                            },
                            {
                                'name' => "Zurich",
                                'lang' => "fr",
                                'flags' => [
                                    "128 (SHORT_NAME)",
                                    "16 (LOCAL_LANG)"
                                ]
                            },
                            {
                                'name' => "Canton de Zurich",
                                'lang' => "fr",
                                'flags' => [
                                    "16 (LOCAL_LANG)",
                                    "1 (PREFERRED)"
                                ]
                            },
                            {
                                'name' => "Canton de Zurich",
                                'lang' => "",
                                'flags' => []
                            },
                            {
                                'name' => "Canton of Zurich",
                                'lang' => "en",
                                'flags' => [
                                    "1 (PREFERRED)"
                                ]
                            },
                            {
                                'name' => "Kanton Zürich",
                                'lang' => "",
                                'flags' => []
                            },
                            {
                                'name' => "Zurich",
                                'lang' => "en",
                                'flags' => [
                                    "128 (SHORT_NAME)"
                                ]
                            },
                            {
                                'name' => "Turitg",
                                'lang' => "rm",
                                'flags' => [
                                    "128 (SHORT_NAME)",
                                    "16 (LOCAL_LANG)"
                                ]
                            },
                            {
                                'name' => "Kanton Zurich",
                                'lang' => "",
                                'flags' => [
                                    "4 (DEACCENT)"
                                ]
                            },
                            {
                                'name' => "취리히 주",
                                'lang' => "ko",
                                'flags' => [
                                    "4 (DEACCENT)",
                                    "1 (PREFERRED)"
                                ]
                            },
                            {
                                'name' => "Zurigo",
                                'lang' => "it",
                                'flags' => [
                                    "128 (SHORT_NAME)",
                                    "16 (LOCAL_LANG)"
                                ]
                            },
                            {
                                'name' => "ZH",
                                'lang' => "abbr",
                                'flags' => [
                                    "1 (PREFERRED)",
                                    "2 (ABBREVIATION)"
                                ]
                            },
                            {
                                'name' => "Chantun Turitg",
                                'lang' => "rm",
                                'flags' => [
                                    "16 (LOCAL_LANG)",
                                    "1 (PREFERRED)"
                                ]
                            },
                            {
                                'name' => "취리히 주",
                                'lang' => "ko",
                                'flags' => [
                                    "1 (PREFERRED)"
                                ]
                            },
                            {
                                'name' => "Zürich",
                                'lang' => "de",
                                'flags' => [
                                    "128 (SHORT_NAME)",
                                    "16 (LOCAL_LANG)"
                                ]
                            },
                            {
                                'name' => "Kanton Zürich",
                                'lang' => "en",
                                'flags' => []
                            },
                            {
                                'name' => "Kanton Zürich",
                                'lang' => "de",
                                'flags' => [
                                    "16 (LOCAL_LANG)",
                                    "1 (PREFERRED)"
                                ]
                            },
                            {
                                'name' => "Kanton Zurich",
                                'lang' => "de",
                                'flags' => [
                                    "16 (LOCAL_LANG)",
                                    "4 (DEACCENT)",
                                    "1 (PREFERRED)"
                                ]
                            },
                            {
                                'name' => "Zürich",
                                'lang' => "",
                                'flags' => []
                            }
                        ],
                        'id' => "'geonameid' =>2657895",
                        'attributes' => {
                            'population' => 1289559
                        },
                        'longId' => "72057594040585831",
                        'parentIds' => [
                            "72057594040586370"
                        ]
                    },
                    {
                        'cc' => "CH",
                        'geometry' => {
                            'center' => {
                                'lat' => 47.00016,
                                'lng' => 8.01427
                            },
                            'bounds' => {
                                'ne' => {
                                    'lat' => 48.2246704102,
                                    'lng' => 10.9423818588
                                },
                                'sw' => {
                                    'lat' => 45.485168457,
                                    'lng' => 5.27343702316
                                }
                            }
                        },
                        'name' => "Switzerland",
                        'displayName' => "Switzerland",
                        'woeType' => "12 (COUNTRY)",
                        'ids' => [
                            {
                                'source' => "geonameid",
                                'id' => "2658434"
                            }
                        ],
                        'names' => [
                            {
                                'name' => "스위스",
                                'lang' => "ko",
                                'flags' => []
                            },
                            {
                                'name' => "Suisse",
                                'lang' => "fr",
                                'flags' => [
                                    "128 (SHORT_NAME)",
                                    "16 (LOCAL_LANG)",
                                    "1 (PREFERRED)"
                                ]
                            }
                        ],
                        'id' => "'geonameid' =>2658434",
                        'attributes' => {
                            'population' => 7581000
                        },
                        'longId' => "72057594040586370",
                        'parentIds' => [
                            "72057594044183084"
                        ]
                    }
                ]
            }
        ]
    }
  end

end