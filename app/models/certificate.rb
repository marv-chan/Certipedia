class Certificate < ActiveRecord::Base

  def self.with_schools(school_list)
      if(school_list == nil)
      return Certificate.all
    else
      list = school_list.keys
      return Certificate.where(school: list)
    end
  end

  def self.all_schools
    all_schools = ['Columbia University', 'New York University', 'Cornell University']
    return all_schools
  end

  def self.all_subjects
    ['Computer Science', 'Business']
  end

  def self.with_filter(school_list, subject_list, order)
    if school_list == []
      school_list = Certificate.all_schools
    end
    if subject_list == []
      subject_list = Certificate.all_subjects
    end
    return Certificate.where(school: school_list, subject: subject_list)
  end

  #def initialize
  #  @schools_to_show = []
  #end

end
