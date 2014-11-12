class CompanyCreator

  def self.create company_params
    company = Company.find_or_initialize_by name: company_params[:name]
    company.employee_ids
    set_employee_ids company, company_params[:employee_ids]
    company.save
    company
  end

  private

  # TODO: probably a model method
  def self.set_employee_ids company, new_employee_ids
    current_employee_ids = company.employee_ids
    current_employee_ids ||= []
    updated_employee_ids = current_employee_ids.concat(new_employee_ids).uniq
    company.employee_ids = updated_employee_ids
  end

end
