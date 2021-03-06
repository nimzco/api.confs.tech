class CitySanatizerService < ApplicationService
  class << self
    delegate :run!, to: :new
  end

  US_CITY_NAME_WITH_STATE = {
    'albany': 'Albany, NY',
    'alexandria': 'Alexandria, VA',
    'anaheim': 'Anaheim, CA',
    'arlington': 'Arlington, VA',
    'aspen': 'Aspen, CO',
    'atlanta': 'Atlanta, GA',
    'augusta': 'Augusta, GA',
    'aurora': 'Aurora, CO',
    'austin': 'Austin, TX',
    'baltimore': 'Baltimore, MD',
    'bandera': 'Bandera, TX',
    'beckenridge': 'Beckenridge, CO',
    'bellevue': 'Bellevue, WA',
    'bend': 'Bend, OR',
    'bloomington': 'Bloomington, MN',
    'boise': 'Boise, ID',
    'boston': 'Boston, MA',
    'boulder': 'Boulder, CO',
    'bremerton': 'Bremerton, WA',
    'brooklyn': 'Brooklyn, NY',
    'broomfield': 'Broomfield, CO',
    'buffalo': 'Buffalo, NY',
    'burlington': 'Burlington, VT',
    'cambridge': 'Cambridge, MA',
    'camden': 'Camden, MN',
    'cape canaveral': 'Cape Canaveral, FL',
    'carlsbad': 'Carlsbad, CA',
    'carmel': 'Carmel, IN',
    'champaign-urbana': 'Champaign-Urbana, IL',
    'charleston': 'Charleston, SC',
    'charlotte': 'Charlotte, NC',
    'chattanooga': 'Chattanooga, TN',
    'chicagexas': 'Chicagexas, IL',
    'chicago': 'Chicago, IL',
    'cincinnati': 'Cincinnati, OH',
    'clear water': 'Clear Water, FL',
    'clearwater': 'Clearwater, FL',
    'cleveland': 'Cleveland, OH',
    'columbia': 'Columbia, SC',
    'dallas': 'Dallas, TX',
    'dayton': 'Dayton, OH',
    'denver': 'Denver, CO',
    'des moines': 'Des Moines, IA',
    'detroit': 'Detroit, MI',
    'east point': 'East Point, GA',
    'fort lauderdale': 'Fort Lauderdale, FL',
    'fort worth': 'Fort Worth, TX',
    'galveston': 'Galveston, TX',
    'grand rapids': 'Grand Rapids, MI',
    'grapevine': 'Grapevine, TX',
    'half moon bay': 'Half Moon Bay, CA',
    'hartford': 'Hartford, CT',
    'henderson': 'Henderson, NV',
    'honolulu': 'Honolulu, HI',
    'houston': 'Houston, TX',
    'huntsville': 'Huntsville, AL',
    'indianapolis': 'Indianapolis, IN',
    'islandia': 'Islandia, NY',
    'jackson': 'Jackson, MS',
    'jacksonville beach': 'Jacksonville Beach, FL',
    'kansas city': 'Kansas City, MO',
    'knoxville': 'Knoxville, TN',
    'la jolla': 'La Jolla, CA',
    'lahaina': 'Lahaina, HI',
    'las vegas': 'Las Vegas, NV',
    'little rock': 'Little Rock, AR',
    'long beach': 'Long Beach, CA',
    'los angeles': 'Los Angeles, CA',
    'madison': 'Madison, WI',
    'mclean': 'McLean, VA',
    'memphis': 'Memphis, TN',
    'menlo park': 'Menlo Park, CA',
    'mesa': 'Mesa, AZ',
    'miami': 'Miami, FL',
    'milwaukee': 'Milwaukee, WI',
    'minneapolis': 'Minneapolis, MN',
    'modesto': 'Modesto, CA',
    'morrisville': 'Morrisville, NC',
    'mountain view': 'Mountain View, CA',
    'nashville': 'Nashville, TN',
    'new haven': 'New Haven, CT',
    'new orleans': 'New Orleans, LA',
    'new york': 'New York, NY',
    'newark': 'Newark, CA',
    'oakland': 'Oakland, CA',
    'oklahoma city': 'Oklahoma City, OK',
    'omaha': 'Omaha, NE',
    'orlando': 'Orlando, FL',
    'palm springs': 'Palm Springs, CA',
    'palo alto': 'Palo Alto, CA',
    'park city': 'Park City, UT',
    'pasadena': 'Pasadena, CA',
    'philadelphia': 'Philadelphia, PA',
    'phoenix': 'Phoenix, AZ',
    'pittsburgh': 'Pittsburgh, PA',
    'pocono manor': 'Pocono Manor, PA',
    'port canaveral': 'Port Canaveral, FL',
    'portland': 'Portland, OR',
    'prince william forest park': 'Prince William Forest Park, VA',
    'princeton': 'Princeton, NJ',
    'providence': 'Providence, RI',
    'raleigh': 'Raleigh, NC',
    'raleigh-durham': 'Raleigh-Durham, NC',
    'redmond': 'Redmond, WA',
    'redwood city': 'Redwood City, CA',
    'reston': 'Reston, VA',
    'richardson': 'Richardson, TX',
    'richmond': 'Richmond, VA',
    'rochester': 'Rochester, NY',
    'rockville': 'Rockville, MD',
    'saint paul': 'Saint Paul, MN',
    'salt lake city': 'Salt Lake City, UT',
    'san antonio': 'San Antonio, TX',
    'san diego': 'San Diego, CA',
    'san francisco': 'San Francisco, CA',
    'san jose': 'San Jose, CA',
    'san mateo': 'San Mateo, CA',
    'sandusky': 'Sandusky, OH',
    'sandy': 'Sandy, UT',
    'santa clara': 'Santa Clara, CA',
    'santa cruz': 'Santa Cruz, CA',
    'santa monica': 'Santa Monica, CA',
    'scottsdale': 'Scottsdale, AZ',
    'seattle': 'Seattle, WA',
    'st. augustine': 'St. Augustine, FL',
    'st. louis': 'St. Louis, MO',
    'st. petersburg': 'St. Petersburg, FL',
    'stamford': 'Stamford, CT',
    'stanford': 'Stanford, CA',
    'sunnyvale': 'Sunnyvale, CA',
    'tacoma': 'Tacoma, WA',
    'tampa': 'Tampa, FL',
    'texas': 'Texas, IL',
    'truckee': 'Truckee, CA',
    'tulsa': 'Tulsa, OK',
    'virginia beach': 'Virginia Beach, VA',
    'walker creek ranch': 'Walker Creek Ranch, CA',
    'washington, d': 'Washington, D.C.',
    'waterloo': 'Waterloo, ON',
    'wisconsin dells': 'Wisconsin Dells, WI'
  }.freeze

  def run!(city, country)
    return 'online' if city.downcase == 'online'

    # Add state if the city is in the US
    # See: https://github.com/tech-conferences/conference-data/blob/main/config/validLocations.js
    return US_CITY_NAME_WITH_STATE[city.downcase.to_sym] || city.titleize if country == 'U.S.A.'

    case city.downcase
    when 'münchen', 'munchen'
      return 'Munich'
    when 'bogotá'
      return 'Bogota'
    when 'medellín'
      return 'Medellin'
    end

    city.titleize
  end
end
