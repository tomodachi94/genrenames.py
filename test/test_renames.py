import unittest

import genrenames as renames  # local

# ensure test functions start with 'test_*' and
# test case classes end with 'TestCase*'

# place test cases under this comment


class UnderscoresTestCase(unittest.TestCase):

    def test_has_underscores(self):
        """
        Checks that a string known to have underscores is recognized by
         `renames._has_underscores`.
        """

        out = renames._has_underscores("This_string_has_underscores")
        self.assertTrue(out)

    def test_has_no_underscores(self):
        """
        Checks that a string not known to have underscores is recognized by
         `renames._has_underscores`.
        """

        out = renames._has_underscores("This string has no underscores")
        self.assertFalse(out)


class GenRenamesTestCase(unittest.TestCase):

    def test_renames_folder(self):
        """
        Tests an example tilesheet folder with `renames.get_renames`.
        """

        out = renames.get_renames("../test/has-renames")
        self.assertEqual("Xbony_s cool pickaxe.png", out)


class ExtensionsTestCase(unittest.TestCase):

    def test_extension_png(self):
        out = renames._has_good_extension("example.png")
        self.assertTrue(out)

    def test_extension_jpg(self):
        out = renames._has_good_extension("example.jpg")
        self.assertTrue(out)

    def test_extension_jpeg(self):
        out = renames._has_good_extension("example.jpeg")
        self.assertTrue(out)

    def test_extension_txt(self):
        out = renames._has_good_extension("example.txt")
        self.assertFalse(out)

    def test_extension_mov(self):
        out = renames._has_good_extension("example.mov")
        self.assertFalse(out)


# no unit tests beyond this point

if __name__ == "__main__":
    unittest.main()
