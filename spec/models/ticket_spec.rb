require 'spec_helper'

describe Ticket do

  describe 'new ticket' do
    describe 'should return ticket with status' do
      let(:ticket){ create(:ticket) }

      it 'should have status waiting for responsed' do
        expect(ticket.waiting_for_responsed?).to eq(true)
      end

      it 'should contains waiting for responsed tickets' do
        expect(Ticket.waiting_for_responsed_tickets).not_to include(ticket)
      end

    end
  end
end