class ActionsController < ApplicationController
  def bandwidth
    txpath = 'cat /sys/class/net/eth0/statistics/tx_bytes'
    rxpath = 'cat /sys/class/net/eth0/statistics/rx_bytes'

    txstart = `#{txpath}`
    rxstart = `#{rxpath}`

    sleep 2

    txend = `#{txpath}`
    rxend = `#{rxpath}`

    result = {}

    result['tx'] = txend.to_i - txstart.to_i
    result['rx'] = rxend.to_i - rxstart.to_i

    render json: result
  end


  def df
    results = `/bin/df -Ph|awk \'{print $1","$2","$3","$4","$5","$6}\'`

    lines = []

    results.split("\n")[1..-1].join("\n").each_line do |result|
      lines << result.chomp.split(",")
    end

    render text: lines
  end


  def hostname
    render text: `/bin/hostname -f`
  end



end
