class Event
  attr_reader :tr_iniciada, :ativa, :processo_efecivacao, :processo_cancelamento, :tr_fim, :efetivada
  def initialize
    @tr_iniciada = Array.new()
    @ativa = Array.new()
    @processo_efecivacao = Array.new()
    @efetivada = Array.new()
    @processo_cancelamento = Array.new()
    @tr_fim = Array.new()
  end

  def tr_begin(string)
    @tr_iniciada << string
  end

  def tr_terminate(string)
    if @ativa.include?(string)
      @ativa.delete(string)
      @processo_efecivacao << string
    else
      puts "Error, transaction not found"
    end
  end

  def write_or_read(string)
    if @ativa.include?(string)
      puts "Update Successful"
    elsif @tr_iniciada.include?(string)
      @tr_iniciada.delete(string)
      @ativa << string
      puts "Update Successful"
    else
      puts "Error, transaction not found"
    end
  end

  def tr_rollback(string)
    if @ativa.include?(string)
      @ativa.delete(string)
      @processo_cancelamento << string
    elsif @processo_efecivacao.include?(string)
      @processo_efecivacao.delete(string)
      @processo_cancelamento << string
    else
      puts "Error, transaction not found"
    end
  end

  def tr_commit(string)
    if @processo_efecivacao.include(string)
      @processo_efecivacao.delete(string)
      @efetivada << string
    else
      puts "Error, transaction not found"
    end
  end

  def tr_finish(string)
    if @processo_cancelamento.include?(string)
      @processo_cancelamento.delete(string)
      @tr_fim << string
    else
      puts "Error, transaction not found"
    end
  end

end
