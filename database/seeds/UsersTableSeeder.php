<?php

use Illuminate\Database\Seeder;
use App\User;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $admin = User::firstOrNew([
            'name' => 'Admin',
            'email' => 'admin@ggness.com'
        ]);

        $admin->password = bcrypt('amazing_admin');
        $admin->save();
    }
}
