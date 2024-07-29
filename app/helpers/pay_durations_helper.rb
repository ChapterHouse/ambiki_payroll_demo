module PayDurationsHelper
  
  def qualifier(pay_duration = assigns['pay_duration'])
    if pay_duration.respond_to?(:qualifier)
      pay_duration.qualifier.to_s.sub('the_','').humanize
    else
      ''
    end
  end
  
  def ending(pay_duration = assigns['pay_duration'])
    if pay_duration.respond_to?(:ending)
      pay_duration.ending.to_s.humanize
    else
      ''
    end
  end

end
