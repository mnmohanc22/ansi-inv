from flask import Blueprint, jsonify, request
import platform
import os

main_bp = Blueprint('main', __name__)


@main_bp.route('/health', methods=['GET'])
def health():
    """Health check endpoint — used by load balancer and systemd watchdog."""
    return jsonify({
        'status'  : 'ok',
        'service' : 'flaskapp',
        'host'    : platform.node(),
    }), 200


@main_bp.route('/api/v1/info', methods=['GET'])
def info():
    """Application info endpoint."""
    return jsonify({
        'app'     : 'flaskapp',
        'version' : '1.0.0',
        'env'     : os.environ.get('FLASK_ENV', 'production'),
        'python'  : platform.python_version(),
    }), 200


@main_bp.route('/api/v1/echo', methods=['POST'])
def echo():
    """Echo endpoint for testing."""
    data = request.get_json(silent=True) or {}
    return jsonify({'echo': data}), 200
