class Certificate < ActiveRecord::Base
  has_many :bookmarks
  has_many :users, :through => :bookmarks

  def self.with_schools(school_list)
      if(school_list == nil)
      return Certificate.all
    else

      list = school_list
      return Certificate.where(school: list)
    end
  end

  def self.all_schools
    return Certificate.select(:school).map(&:school).uniq
  end

  def self.all_subjects
    return Certificate.select(:subject).map(&:subject).uniq
  end

  def self.with_filter(school_list, subject_list)
    if school_list == []
      school_list = Certificate.all_schools
    end
    if subject_list == []
      subject_list = Certificate.all_subjects
    end
    return Certificate.where(school: school_list, subject: subject_list)
  end

  def origin
    if self.school == 'New York University'
      "https://www.nyu.edu"
    elsif self.school == 'Cornell University'
      "https://www.cornell.edu"
    else
      "https://www.columbia.edu"
    end
  end
end
