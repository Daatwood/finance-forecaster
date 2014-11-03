module BillsHelper

  def accounts_bip_collection(accounts)
    accounts.inject({}){|hsh,acc| hsh[acc.id] = acc.name; hsh}
  end

end
