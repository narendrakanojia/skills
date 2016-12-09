require 'rails_helper'

describe PeopleController do
  describe 'PeoplController' do
    before { auth(:ken) }
    before { load_pictures }

    describe 'Export person as odt' do
      it 'returns bob' do
        bob = people(:bob)

        expect_any_instance_of(Person)
          .to receive(:export)
          .exactly(1).times
          .and_call_original

        expect_any_instance_of(ODFReport::Report)
          .to receive(:add_field)
          .exactly(14).times
          .and_call_original

        expect_any_instance_of(ODFReport::Report)
          .to receive(:add_image)
          .exactly(1).times
          .and_call_original

        expect_any_instance_of(ODFReport::Report)
          .to receive(:add_table)
          .exactly(4).times
          .and_call_original

        process :show, method: :get, format: 'odt', params: { id: bob.id }
      end

      it 'check filename' do
        process :show, method: :get, format: 'odt', params: { id: people(:bob).id }
        expect(@response['Content-Disposition']).to match(
          /filename="bob_anderson_cv.odt"/
        )
      end
    end

    describe 'GET index' do
      it 'returns all people without nested models' do
        keys = %w(name)

        get :index

        people = json['data']

        expect(people.count).to eq(2)
        alice_attrs = people.first['attributes']
        expect(alice_attrs.count).to eq(1)
        expect(alice_attrs.first[1]).to eq("Alice Mante")
        json_object_includes_keys(alice_attrs, keys)
        expect(people).not_to include('relationships')
      end

      describe 'GET show' do
        it 'returns person with nested modules' do
          keys = %w(birthdate picture language location martial-status updated-by name origin
                    role title)

          bob = people(:bob)

          process :show, method: :get, params: { id: bob.id }

          bob_attrs = json['data']['attributes']

          expect(bob_attrs.count).to eq(10)
          json_object_includes_keys(bob_attrs, keys)
          expect(bob_attrs['picture']).to eq(bob.picture.url)

          nested_keys = %w(advanced-trainings activities projects educations competences status)
          nested_attrs = json['data']['relationships']

          expect(nested_attrs.count).to eq(6)
          json_object_includes_keys(nested_attrs, nested_keys)
        end

        describe 'POST create' do
          it 'creates new person' do
            person = { birthdate: Time.now,
                       picture: fixture_file_upload('files/picture.png','image/png'),
                       language: 'German',
                       location: 'Bern',
                       martial_status: 'single',
                       name: 'test',
                       origin: 'Switzerland',
                       role: 'tester',
                       title: 'Bsc in tester',
                       status_id: 2 }

            process :create, method: :post, params: { person: person }

            new_person = Person.find_by(name: 'test')
            expect(new_person).not_to eq(nil)
            expect(new_person.location).to eq('Bern')
            expect(new_person.language).to eq('German')
            expect(new_person.picture.url).to eq("/uploads/person/picture/#{new_person.id}/picture.png")
          end
        end

        describe 'PUT update' do
          it 'updates existing person' do
            bob = people(:bob)

            process :update, method: :put, params: { id: bob.id, person: { location: 'test_location' } }

            bob.reload
            expect(bob.location).to eq('test_location')
          end
        end

        describe 'DELETE destroy' do
          it 'destroys existing person' do
            bob = people(:bob)
            process :destroy, method: :delete, params: { id: bob.id }

            expect(Person.exists?(bob.id)).to eq(false)
            expect(Activity.exists?(person_id: bob.id)).to eq(false)
            expect(AdvancedTraining.exists?(person_id: bob.id)).to eq(false)
            expect(Project.exists?(person_id: bob.id)).to eq(false)
            expect(Education.exists?(person_id: bob.id)).to eq(false)
            expect(Competence.exists?(person_id: bob.id)).to eq(false)
          end
        end
      end
    end
  end

  describe 'authentication' do
    it 'renders unauthorized if no params' do
      process :index, method: :get, params: {}
      expect(response.status).to eq(401)
    end

    it 'render unauthorized if user does not exists' do
      process :index, method: :get, params: { ldap_uid: 0o000, api_token: 'test' }

      expect(response.status).to eq(401)
    end

    it 'render unauthorized if api_token doesnt match' do
      process :index, method: :get, params: { ldap_uid: users(:ken).ldap_uid,
                                              api_token: 'wrong token' }

      expect(response.status).to eq(401)
    end

    it 'does nothing if api_token is correct' do
      ken = users(:ken)
      process :index, method: :get, params: { ldap_uid: ken.ldap_uid,
                                              api_token: ken.api_token }

      expect(response.status).to eq(200)
    end
  end
end
