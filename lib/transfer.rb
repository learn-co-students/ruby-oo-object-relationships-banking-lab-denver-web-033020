class Transfer
  attr_accessor :sender, :receiver, :status, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
  end

  def valid?
    @sender.valid? == true && @receiver.valid? == true
  end

  def execute_transaction
    puts "#{@sender.name} has #{@sender.balance}"
    puts "#{@receiver.name} has #{@receiver.balance}"
    puts @amount
    if valid? == false
      self.status = 'rejected'
      return "Transaction rejected. Please check your account balance."
      end

    if @sender.balance < @amount 
      self.status = 'rejected'
      return "Transaction rejected. Please check your account balance."
    end
    
    if @sender.balance >= @amount && self.status == 'pending'
      @sender.balance = @sender.balance - @amount
      @receiver.balance += @amount
      self.status = 'complete'
    end
  end

  def reverse_transfer
    if self.status == 'complete'
      @sender.balance = @sender.balance + @amount
      @receiver.balance = @receiver.balance - @amount
      self.status = 'reversed'
    end
  end
end
