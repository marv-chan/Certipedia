class Certificate < ActiveRecord::Base

  def self.all_schools
    ['Columbia University', 'New York University', 'Cornell University']
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

end
