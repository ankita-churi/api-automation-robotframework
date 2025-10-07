import json
from pathlib import Path


_loaded_data = None


def get_test_data_field(testname):

    """
    Fetch entire test case data (dict) from JSON using only test ID prefix (e.g., 'TC01').
    Example:
        testname = 'TC02 Custom word censored with default value *'
        returns JSON object for 'TC02'
    """
    global _loaded_data

    # Load JSON once and cache it
    if _loaded_data is None:
        project_root = Path(__file__).parent.parent
        json_path = project_root / "data" / "test_data.json"

        try:
            with open(json_path, "r", encoding="utf-8") as f:
                _loaded_data = json.load(f)
            print(f"DEBUG: Loaded test data from {json_path}")
        except FileNotFoundError:
            raise FileNotFoundError(f"Test data file not found: {json_path}")
        except json.JSONDecodeError as e:
            raise ValueError(f"Invalid JSON format: {e}")

    # Extract test ID (first token like TC01)
    try:
        tc_id = testname.split()[0]
        tc_data = _loaded_data["test_cases"].get(tc_id)

        if not tc_data:
            print(f"DEBUG: No test data found for ID '{tc_id}'")
            return None

        print(f"DEBUG: Extracted data for '{tc_id}': {tc_data}")
        return tc_data

    except Exception as e:
        print(f"DEBUG: Failed to read test data for '{testname}': {e}")
        return None
