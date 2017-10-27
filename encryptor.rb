class Encryptor

  def cipher(rotation)
  characters = (' '..'z').to_a
  encryption_characters = characters.rotate(rotation)
  Hash[characters.zip(encryption_characters)]
  end

  def encrypt_letter(letter, rotation)
    cipher_for_rotation = cipher(rotation)
    cipher_for_rotation[letter]
  end

  def encrypt(string, rotation)
    letters = string.split('')
    letters.collect! { |letter| encrypt_letter(letter, rotation) }
    letters.join
  end

  def decrypt(string, rotation)
    reverse_rotation = cipher(rotation).length - rotation
    encrypt(string, reverse_rotation)
  end

  def supported_characters
    (' '..'z').to_a
  end

  def crack(message)
    supported_characters.count.times.collect do |attempt|
      decrypt(message, attempt)
    end
  end

  def encrypt_file(filename, rotation)
    secret = File.open(filename, "r")
    secret = secret.read
    encryption = encrypt(secret, rotation)
    encrypted_file_name = filename + '.encrypted'
    encrypted_file = File.open(encrypted_file_name, "w")
    encrypted_file.write(encryption)
    encrypted_file.close
  end

  def decrypt_file(filename, rotation)
    secret = File.open(filename, "r")
    secret = secret.read
    decryption = decrypt(secret, rotation)
    decrypted_file_name = filename.gsub("encrypted", "decrypted")
    decrypted_file = File.open(decrypted_file_name, "w")
    decrypted_file.write(decryption)
    decrypted_file.close
  end
end
