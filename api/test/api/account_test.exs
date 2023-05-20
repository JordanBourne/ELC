defmodule Api.AccountTest do
  use Api.DataCase

  alias Api.Account

  describe "user" do
    alias Api.Account.User

    import Api.AccountFixtures

    @invalid_attrs %{email: nil, name: nil, password: nil}

    test "list_user/0 returns all user" do
      user = user_fixture()
      assert Account.list_user() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Account.get_user!(user.id) == user
    end

    test "get_user_by_email/1 returns the user with given email" do
      user = user_fixture()
      assert Account.get_user_by_email(user.email) == user
    end

    test "authenticate_user/1 returns the user when given correct email and password" do
      user = user_fixture()
      assert Account.authenticate_user(user.email, "some password") == {:ok, user}
    end

    test "authenticate_user/1 returns error when given incorrect password" do
      user = user_fixture()
      assert Account.authenticate_user(user.email, "bad password") == {:error, :invalid_credentials}
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "some email", name: "some name", password: "some password"}

      assert {:ok, %User{} = user} = Account.create_user(valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
      assert user.password_hash != nil
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{email: "some updated email", name: "some updated name", password: "some updated password"}

      assert {:ok, %User{} = updated_user} = Account.update_user(user, update_attrs)
      assert updated_user.email == "some updated email"
      assert updated_user.name == "some updated name"
      assert updated_user.password_hash != user.password_hash
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user.name == Account.get_user!(user.id).name
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Account.change_user(user)
    end
  end
end
